import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/onboarding/application/providers/onboarding_providers.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/onboarding_step_view.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/step_indicator.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingNotifierProvider.notifier).start();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(onboardingNotifierProvider);

    if (currentStep == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ref.read(onboardingCompletedProvider.notifier).state = true;
          context.go('/');
        }
      });
      return const SizedBox.shrink();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    ref.read(onboardingNotifierProvider.notifier).skip();
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
                    ref.read(onboardingNotifierProvider.notifier).next();
                  },
                  child: Text(
                    currentStep.isLast
                        ? context.l10n.getStarted
                        : context.l10n.next,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
