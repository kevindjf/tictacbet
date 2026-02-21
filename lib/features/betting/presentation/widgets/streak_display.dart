import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/streak.dart';

class StreakDisplay extends StatelessWidget {
  const StreakDisplay({super.key, required this.streak});

  final Streak streak;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_fire_department,
              color: streak.count > 0
                  ? betclic.streakColor
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: AppDimensions.iconL,
            ),
            const SizedBox(width: AppDimensions.spacingS),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.streak,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  context.l10n.streakCount(streak.count),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(width: AppDimensions.spacingM),
            Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingS,
                    vertical: AppDimensions.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: betclic.streakColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    border: Border.all(
                      color: betclic.streakColor.withAlpha(80),
                    ),
                  ),
                  child: Text(
                    context.l10n.multiplier(
                      streak.multiplier.toStringAsFixed(1),
                    ),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: betclic.streakColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
                .animate(target: streak.count > 0 ? 1 : 0)
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  duration: 300.ms,
                ),
          ],
        ),
      ),
    );
  }
}
