import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/bet_slider.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/coin_balance.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/matchmaking/application/providers/matchmaking_providers.dart';
import 'package:tic_tac_bet/features/matchmaking/data/repositories/mock_matchmaking_repository.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/match_proposal.dart';
import 'package:tic_tac_bet/features/matchmaking/presentation/widgets/match_proposal_card.dart';

class LobbyPage extends ConsumerWidget {
  const LobbyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposalsAsync = ref.watch(lobbyProposalsProvider);
    final wallet = ref.watch(walletControllerProvider);
    final hasWaitingProposal = proposalsAsync.maybeWhen(
      data: (proposals) => proposals.any(
        (p) =>
            p.creatorId == MockMatchmakingRepository.localUserId && p.isWaiting,
      ),
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.lobby)),
      floatingActionButton: hasWaitingProposal
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _showCreateMatchSheet(context),
              backgroundColor: AppColors.neonGold,
              foregroundColor: AppColors.accessibleDark,
              icon: const Icon(Icons.add),
              label: Text(context.l10n.createMatch),
            ),
      body: AppPatternBackground(
        child: proposalsAsync.when(
          data: (proposals) {
            final myWaitingCandidates = proposals
                .where(
                  (p) =>
                      p.creatorId == MockMatchmakingRepository.localUserId &&
                      p.isWaiting,
                )
                .toList();
            final myWaitingProposal = myWaitingCandidates.isEmpty
                ? null
                : myWaitingCandidates.first;

            final available = proposals
                .where((p) => p.isWaiting)
                .where(
                  (p) => p.creatorId != MockMatchmakingRepository.localUserId,
                )
                .toList();

            return ListView(
              padding: const EdgeInsets.all(AppDimensions.spacingM),
              children: [
                if (myWaitingProposal != null) ...[
                  _MyWaitingProposalCard(
                    proposal: myWaitingProposal,
                    onCancel: () async {
                      await ref
                          .read(matchmakingRepositoryProvider)
                          .cancelProposal(myWaitingProposal.id);
                      final currentBet = ref.read(currentBetProvider);
                      if (currentBet != null) {
                        await ref
                            .read(walletControllerProvider.notifier)
                            .refundBet(currentBet.amount);
                        ref.read(currentBetProvider.notifier).clear();
                      }
                    },
                    onSimulateOpponent: () async {
                      final currentBet = ref.read(currentBetProvider);
                      if (currentBet == null) return;

                      final session = await ref
                          .read(mockMatchmakingRepositoryProvider)
                          .simulateOpponentAccept(myWaitingProposal.id);
                      ref
                          .read(currentMockSessionProvider.notifier)
                          .setSession(session);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.l10n.matchAccepted)),
                        );
                        context.pushNamed(
                          'game',
                          extra: const GameMode.online(),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: AppDimensions.spacingM),
                ],
                if (available.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spacingL),
                      child: Column(
                        children: [
                          Icon(
                            Icons.groups_2_outlined,
                            size: 32,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: AppDimensions.spacingS),
                          Text(
                            context.l10n.createMatch,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppDimensions.spacingXS),
                          Text(
                            context.l10n.simulateOpponent,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...available.map(
                    (proposal) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppDimensions.spacingS,
                      ),
                      child: MatchProposalCard(
                        proposal: proposal,
                        enabled:
                            myWaitingProposal == null &&
                            wallet.availableBalance >= proposal.betAmount,
                        onAccept: () async {
                          final bet = await ref
                              .read(bettingServiceProvider)
                              .place(proposal.betAmount);
                          if (bet == null) return;

                          ref.read(currentBetProvider.notifier).setBet(bet);
                          final session = await ref
                              .read(matchmakingRepositoryProvider)
                              .acceptProposal(proposal.id);
                          ref
                              .read(currentMockSessionProvider.notifier)
                              .setSession(session);

                          if (context.mounted) {
                            _showAcceptedMessage(context);
                            context.pushNamed(
                              'game',
                              extra: const GameMode.online(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 88),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
        ),
      ),
    );
  }

  Future<void> _showCreateMatchSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => const _CreateMatchBottomSheet(),
    );
  }

  void _showAcceptedMessage(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.matchAccepted)));
  }
}

class _CreateMatchBottomSheet extends ConsumerStatefulWidget {
  const _CreateMatchBottomSheet();

  @override
  ConsumerState<_CreateMatchBottomSheet> createState() =>
      _CreateMatchBottomSheetState();
}

class _CreateMatchBottomSheetState
    extends ConsumerState<_CreateMatchBottomSheet> {
  static const int _minimumBet = 1;
  int _betAmount = _minimumBet;

  int _clampBetAmount(int maxAvailable) {
    if (maxAvailable < _minimumBet) return _minimumBet;
    return _betAmount.clamp(_minimumBet, maxAvailable);
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletControllerProvider);
    final canPlaceBet = wallet.availableBalance >= _minimumBet;
    final clampedBetAmount = _clampBetAmount(wallet.availableBalance);

    if (_betAmount != clampedBetAmount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _betAmount = clampedBetAmount);
        }
      });
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppDimensions.spacingM,
          right: AppDimensions.spacingM,
          top: AppDimensions.spacingS,
          bottom:
              MediaQuery.of(context).viewInsets.bottom + AppDimensions.spacingM,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.createMatch,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXS),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.minimumBet(1),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingM),
              CoinBalance(balance: wallet.balance),
              const SizedBox(height: AppDimensions.spacingM),
              BetSlider(
                currentBet: clampedBetAmount,
                maxBet: wallet.availableBalance,
                minimumBet: _minimumBet,
                onChanged: (value) => setState(() => _betAmount = value),
              ),
              const SizedBox(height: AppDimensions.spacingM),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      canPlaceBet && clampedBetAmount <= wallet.availableBalance
                      ? () async {
                          final bet = await ref
                              .read(bettingServiceProvider)
                              .place(clampedBetAmount, minimumBet: _minimumBet);
                          if (bet == null || !context.mounted) return;

                          ref.read(currentBetProvider.notifier).setBet(bet);
                          await ref
                              .read(matchmakingRepositoryProvider)
                              .createProposal(clampedBetAmount);
                          if (!context.mounted) return;

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.l10n.waitingForOpponent),
                            ),
                          );
                        }
                      : null,
                  child: Text(context.l10n.betAmount(clampedBetAmount)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyWaitingProposalCard extends StatelessWidget {
  const _MyWaitingProposalCard({
    required this.proposal,
    required this.onCancel,
    required this.onSimulateOpponent,
  });

  final MatchProposal proposal;
  final VoidCallback onCancel;
  final VoidCallback onSimulateOpponent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.waitingForOpponent,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            Text(
              context.l10n.betAmount(proposal.betAmount),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            Row(
              children: [
                OutlinedButton(
                  onPressed: onCancel,
                  child: Text(context.l10n.cancelMatch),
                ),
                const SizedBox(width: AppDimensions.spacingS),
                ElevatedButton(
                  onPressed: onSimulateOpponent,
                  child: Text(context.l10n.simulateOpponent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
