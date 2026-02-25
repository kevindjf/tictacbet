import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/router/app_router.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/bet_slider.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/coin_balance.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/matchmaking/application/providers/matchmaking_providers.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/match_proposal.dart';
import 'package:tic_tac_bet/features/matchmaking/presentation/widgets/match_proposal_card.dart';

class LobbyPage extends ConsumerWidget {
  const LobbyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmAsync = ref.watch(lobbyViewModelProvider);
    final wallet = ref.watch(walletControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.lobby)),
      floatingActionButton: vmAsync.maybeWhen(
        data: (vm) => vm.hasWaitingProposal
            ? null
            : FloatingActionButton.extended(
                onPressed: () => _showCreateMatchSheet(context),
                backgroundColor: AppColors.neonGold,
                foregroundColor: AppColors.accessibleDark,
                icon: const Icon(Icons.add),
                label: Text(context.l10n.createMatch),
              ),
        orElse: () => null,
      ),
      body: AppPatternBackground(
        child: vmAsync.when(
          data: (vm) {
            final myWaitingProposal = vm.myWaitingProposal;
            final available = vm.availableProposals;

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
                          AppRouter.game,
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
                            size: AppDimensions.iconL,
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
                              AppRouter.game,
                              extra: const GameMode.online(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: AppDimensions.fabClearance),
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

class _CreateMatchBottomSheet extends ConsumerWidget {
  const _CreateMatchBottomSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(betPlacementViewModelProvider(true));

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
                  context.l10n.minimumBet(Wallet.minimumBet),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingM),
              CoinBalance(balance: vm.wallet.balance),
              const SizedBox(height: AppDimensions.spacingM),
              BetSlider(
                currentBet: vm.clampedAmount,
                maxBet: vm.wallet.availableBalance,
                minimumBet: Wallet.minimumBet,
                potentialWinnings: vm.potentialWinnings,
                enabled: vm.canPlace,
                onChanged: (value) =>
                    ref
                        .read(betPlacementAmountProvider(true).notifier)
                        .state = value,
              ),
              const SizedBox(height: AppDimensions.spacingM),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: vm.canPlace
                      ? () async {
                          final bet = await ref
                              .read(bettingServiceProvider)
                              .place(vm.clampedAmount);
                          if (bet == null || !context.mounted) return;

                          ref.read(currentBetProvider.notifier).setBet(bet);
                          await ref
                              .read(matchmakingRepositoryProvider)
                              .createProposal(vm.clampedAmount);
                          if (!context.mounted) return;

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.l10n.waitingForOpponent),
                            ),
                          );
                        }
                      : null,
                  child: Text(context.l10n.betAmount(vm.clampedAmount)),
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
