import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Clears onboarding completion state.
class ResetOnboardingUseCase {
  const ResetOnboardingUseCase(this._repository);

  final OnboardingRepository _repository;

  /// Resets onboarding completion flag in persistence.
  Future<void> call() => _repository.reset();
}
