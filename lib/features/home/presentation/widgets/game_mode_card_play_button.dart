import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/constants/app_durations.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';

class GameModeCardPlayButton extends StatelessWidget {
  const GameModeCardPlayButton({
    super.key,
    required this.label,
    required this.color,
    this.isPressed = false,
  });

  final String label;
  final Color color;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDurations.instant,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(isPressed ? 70 : 100),
            blurRadius: isPressed ? 12 : 20,
            offset: Offset(0, isPressed ? 6 : 10),
          ),
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.accessibleDark,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
