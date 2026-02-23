import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';

class VictoryTrophySection extends StatelessWidget {
  const VictoryTrophySection({super.key});

  @override
  Widget build(BuildContext context) {
    final betclic = context.betclic;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.emoji_events,
          size: AppDimensions.iconXL * 2,
          color: betclic.coinColor,
        ).animate().scale(
          begin: const Offset(0, 0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
        ),
        const SizedBox(height: AppDimensions.spacingL),
        Text(
          context.l10n.tutorialVictoryTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: betclic.playerXColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 400),
        ),
      ],
    );
  }
}
