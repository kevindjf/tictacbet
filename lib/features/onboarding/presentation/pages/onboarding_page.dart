import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/onboarding/application/providers/onboarding_providers.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/onboarding_step_view.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/step_indicator.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/tutorial_game_simulation.dart';

/// Main page for the onboarding flow.
///
/// Renders standard step views or delegates to [TutorialGameSimulation] for
/// the interactive simulation step.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  ProviderSubscription<OnboardingStep?>? _stepSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingControllerProvider.notifier).start();
    });
    _stepSubscription = ref.listenManual<OnboardingStep?>(
      onboardingControllerProvider,
      (previous, next) {
        if (previous != null && next == null && mounted) {
          ref.read(onboardingCompletedProvider.notifier).setValue(true);
          context.go('/');
        }
      },
    );
  }

  @override
  void dispose() {
    _stepSubscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(onboardingControllerProvider);

    if (currentStep == null) return const SizedBox.shrink();

    // The simulation step takes full control of its own layout.
    if (currentStep == OnboardingStep.simulation) {
      return Scaffold(
        body: TutorialGameSimulation(
          onComplete: () {
            unawaited(
              ref.read(onboardingControllerProvider.notifier).complete(),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: AppPatternBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingM),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      unawaited(
                        ref.read(onboardingControllerProvider.notifier).skip(),
                      );
                    },
                    child: Text(context.l10n.skip),
                  ),
                ),
                const Spacer(),
                OnboardingStepView(step: currentStep)
                    .animate(key: ValueKey(currentStep))
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: 0.1),
                const Spacer(),
                StepIndicator(
                  currentStep: currentStep,
                  totalSteps: OnboardingStep.values.length,
                ),
                const SizedBox(height: AppDimensions.spacingL),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      unawaited(
                        ref.read(onboardingControllerProvider.notifier).next(),
                      );
                    },
                    child: Text(
                      currentStep == OnboardingStep.game
                          ? context.l10n.getStarted
                          : context.l10n.next,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
