import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';

/// Styled info pill used in [GameTopBar] — wallet balance or active bet.
class GameTopBarPill extends StatelessWidget {
  const GameTopBarPill({
    super.key,
    required this.label,
    required this.tint,
    required this.textColor,
  });

  final String label;
  final Color tint;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingM,
        vertical: AppDimensions.spacingS,
      ),
      decoration: BoxDecoration(
        color: tint.withAlpha(40),
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
        border: Border.all(color: tint.withAlpha(70)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w800,
          color: textColor,
          shadows: [Shadow(color: tint.withAlpha(120), blurRadius: 4)],
        ),
      ),
    );
  }
}
