import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';

class OnboardingStepView extends StatelessWidget {
  const OnboardingStepView({super.key, required this.step});

  final OnboardingStep step;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;

    final (icon, title, description, color) = switch (step) {
      OnboardingStep.welcome => (
        Icons.casino,
        context.l10n.welcomeTitle,
        context.l10n.appTitle,
        Theme.of(context).colorScheme.primary,
      ),
      OnboardingStep.board => (
        Icons.grid_3x3,
        context.l10n.onboardingBoard,
        '',
        betclic.playerXColor,
      ),
      OnboardingStep.game => (
        Icons.sports_esports,
        context.l10n.onboardingGame,
        '',
        betclic.playerOColor,
      ),
      OnboardingStep.streaks => (
        Icons.local_fire_department,
        context.l10n.onboardingStreaks,
        '',
        betclic.streakColor,
      ),
      // simulation step is rendered separately in OnboardingPage
      OnboardingStep.simulation => (
        Icons.play_arrow,
        context.l10n.tutorialSimulationTitle,
        '',
        Theme.of(context).colorScheme.primary,
      ),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 80, color: color),
        const SizedBox(height: AppDimensions.spacingXL),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        if (description.isNotEmpty) ...[
          const SizedBox(height: AppDimensions.spacingM),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
