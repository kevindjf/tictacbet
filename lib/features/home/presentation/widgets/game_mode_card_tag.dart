import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';

class GameModeCardTag extends StatelessWidget {
  const GameModeCardTag({super.key, required this.tag, required this.color});

  final String tag;
  final Color color;
  static const _accessibleDarkText = Color(0xFF111111);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingM,
        vertical: AppDimensions.spacingXS,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Text(
        tag.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: _accessibleDarkText,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
