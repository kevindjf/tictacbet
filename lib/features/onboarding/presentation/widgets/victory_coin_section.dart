import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';

/// Animated coin reward block displayed on the onboarding victory screen.
class VictoryCoinSection extends StatelessWidget {
  const VictoryCoinSection({super.key, required this.coinAnimation});

  final Animation<int> coinAnimation;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingS,
              ),
              child:
                  Icon(
                        Icons.monetization_on,
                        size: AppDimensions.iconL,
                        color: betclic.coinColor,
                      )
                      .animate(delay: Duration(milliseconds: i * 100))
                      .slideY(
                        begin: -1.5,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      )
                      .fadeIn(),
            ),
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 400)),
        const SizedBox(height: AppDimensions.spacingL),
        AnimatedBuilder(
          animation: coinAnimation,
          builder: (context, _) {
            return Text(
              context.l10n.tutorialRewardCoins(coinAnimation.value),
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: betclic.coinColor,
                fontWeight: FontWeight.w900,
              ),
            );
          },
        ),
        const SizedBox(height: AppDimensions.spacingS),
        Text(
          context.l10n.tutorialRewardSubtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(
          delay: const Duration(milliseconds: 600),
          duration: const Duration(milliseconds: 400),
        ),
      ],
    );
  }
}
