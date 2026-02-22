import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_statistics.dart';
import 'package:tic_tac_bet/features/history/presentation/widgets/stat_item.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({super.key, required this.statistics});

  final GameStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;
    final winRatePercent = (statistics.winRate * 100).toStringAsFixed(0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.statistics,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatItem(
                  label: context.l10n.gamesPlayed,
                  value: '${statistics.totalGames}',
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                StatItem(
                  label: context.l10n.winRate,
                  value: '$winRatePercent%',
                  color: betclic.playerXColor,
                ),
                StatItem(
                  label: context.l10n.wins,
                  value: '${statistics.wins}',
                  color: betclic.playerXColor,
                ),
                StatItem(
                  label: context.l10n.losses,
                  value: '${statistics.losses}',
                  color: betclic.playerOColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
