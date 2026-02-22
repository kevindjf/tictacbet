import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/match_proposal.dart';

class MatchProposalCard extends StatelessWidget {
  const MatchProposalCard({
    super.key,
    required this.proposal,
    required this.onAccept,
    required this.enabled,
  });

  final MatchProposal proposal;
  final VoidCallback onAccept;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: betclic.playerXColor.withAlpha(30),
              child: Text(
                proposal.creatorName.characters.first.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: betclic.playerXColor,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proposal.creatorName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppDimensions.spacingXS),
                  Text(
                    context.l10n.betAmount(proposal.betAmount),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: betclic.coinColor,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: enabled ? onAccept : null,
              child: Text(context.l10n.acceptMatch),
            ),
          ],
        ),
      ),
    );
  }
}
