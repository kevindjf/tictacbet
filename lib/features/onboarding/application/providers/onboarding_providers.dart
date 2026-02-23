import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';
import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:tic_tac_bet/features/onboarding/domain/use_cases/check_onboarding_completed.dart';
import 'package:tic_tac_bet/features/onboarding/domain/use_cases/complete_onboarding.dart';
import 'package:tic_tac_bet/features/onboarding/domain/use_cases/reset_onboarding.dart';

part 'onboarding_providers.g.dart';

@Riverpod(keepAlive: true)
/// Provides the Hive onboarding box used by the onboarding repository.
Box<dynamic> onboardingBox(Ref ref) {
  return Hive.box(OnboardingRepositoryImpl.boxName);
}

@Riverpod(keepAlive: true)
/// Provides the onboarding repository abstraction backed by Hive.
OnboardingRepository onboardingRepository(Ref ref) {
  return OnboardingRepositoryImpl(ref.watch(onboardingBoxProvider));
}

@Riverpod(keepAlive: true)
/// Provides the use case that reads onboarding completion state.
CheckOnboardingCompletedUseCase checkOnboardingCompletedUseCase(Ref ref) {
  return CheckOnboardingCompletedUseCase();
}

@Riverpod(keepAlive: true)
/// Provides the use case that marks onboarding as completed.
CompleteOnboardingUseCase completeOnboardingUseCase(Ref ref) {
  return CompleteOnboardingUseCase();
}

@Riverpod(keepAlive: true)
/// Provides the use case that resets onboarding completion state.
ResetOnboardingUseCase resetOnboardingUseCase(Ref ref) {
  return ResetOnboardingUseCase();
}

@Riverpod(keepAlive: true)
/// Stores the persisted onboarding completion flag.
class OnboardingCompleted extends _$OnboardingCompleted {
  @override
  bool build() {
    final repository = ref.watch(onboardingRepositoryProvider);
    final useCase = ref.watch(checkOnboardingCompletedUseCaseProvider);
    return useCase(repository);
  }

  void setValue(bool value) => state = value;
}

@Riverpod(keepAlive: true)
/// Controls the in-memory onboarding step flow.
///
/// `start -> next* -> complete`, with `skip` and `reset` helpers.
class OnboardingController extends _$OnboardingController {
  OnboardingRepository get _repository =>
      ref.read(onboardingRepositoryProvider);
  CompleteOnboardingUseCase get _completeUseCase =>
      ref.read(completeOnboardingUseCaseProvider);
  ResetOnboardingUseCase get _resetUseCase =>
      ref.read(resetOnboardingUseCaseProvider);

  @override
  OnboardingStep? build() => null;

  void start() {
    state = OnboardingStep.welcome;
  }

  Future<void> next() async {
    final current = state;
    if (current == null) return;
    state = current.next;
    if (state == null) {
      await complete();
    }
  }

  Future<void> skip() async {
    await complete();
  }

  Future<void> complete() async {
    state = null;
    await _completeUseCase(_repository);
  }

  Future<void> reset() async {
    await _resetUseCase(_repository);
  }
}
