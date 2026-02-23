import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final betclic = context.betclic;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'X',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: betclic.playerXColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingS,
          ),
          child: Icon(
            Icons.casino,
            size: AppDimensions.iconXL,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          'O',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: betclic.playerOColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8));
  }
}
