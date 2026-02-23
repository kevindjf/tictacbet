import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';

class HomeTopBarIconButton extends StatelessWidget {
  const HomeTopBarIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.accentColor,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final tint = accentColor ?? AppColors.neonBlue;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppDimensions.topBarIconButtonSize,
        height: AppDimensions.topBarIconButtonSize,
        decoration: BoxDecoration(
          color: tint.withAlpha(40),
          shape: BoxShape.circle,
          border: Border.all(color: tint.withAlpha(70)),
        ),
        child: Icon(
          icon,
          size: AppDimensions.iconM,
          color: AppColors.darkTextPrimary.withAlpha(220),
        ),
      ),
    );
  }
}
