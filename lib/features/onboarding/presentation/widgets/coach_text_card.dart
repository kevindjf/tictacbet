import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';

/// Styled card used inside onboarding coach-mark overlays.
class CoachTextCard extends StatelessWidget {
  const CoachTextCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final betclic = context.betclic;

    return Container(
      constraints: const BoxConstraints(
        maxWidth: AppDimensions.coachCardMaxWidth,
      ),
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: betclic.coachCardBackgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: betclic.coachCardBorderColor),
        boxShadow: [
          BoxShadow(
            color: betclic.coachCardShadowColor,
            blurRadius: AppDimensions.spacingM,
            offset: const Offset(0, AppDimensions.spacingS),
          ),
        ],
      ),
      child: child,
    );
  }
}
