import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/streak.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.lobby)),
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
                .where((p) => p.creatorId != MockMatchmakingRepository.localUserId)
                .toList();

            return ListView(
              padding: const EdgeInsets.all(AppDimensions.spacingM),
              children: [
                _LobbyHeader(
                  onCreate: myWaitingProposal == null
                      ? () => context.pushNamed('createMatch')
                      : null,
                ),
                const SizedBox(height: AppDimensions.spacingM),
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
                        context.pushNamed('game', extra: const GameMode.online());
                      }
                    },
                  ),
                  const SizedBox(height: AppDimensions.spacingM),
                ],
                if (available.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacingXL),
                    child: Center(child: Text(context.l10n.noProposals)),
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
                          final streak = ref.read(streakControllerProvider);
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
                            _showAcceptedMessage(context, streak);
                            context.pushNamed(
                              'game',
                              extra: const GameMode.online(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
        ),
      ),
    );
  }

  void _showAcceptedMessage(BuildContext context, Streak streak) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${context.l10n.matchAccepted} • ${context.l10n.multiplier(streak.multiplier.toStringAsFixed(1))}',
        ),
      ),
    );
  }
}

class _LobbyHeader extends StatelessWidget {
  const _LobbyHeader({required this.onCreate});

  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            context.l10n.proposeMatch,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        ElevatedButton.icon(
          onPressed: onCreate,
          icon: const Icon(Icons.add),
          label: Text(context.l10n.createMatch),
        ),
      ],
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
              style: Theme.of(context).textTheme.bodyMedium,
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
