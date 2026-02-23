import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';

class GameModeCardPlayButton extends StatelessWidget {
  const GameModeCardPlayButton({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  static const _accessibleDarkText = Color(0xFF111111);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(100),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: _accessibleDarkText,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
