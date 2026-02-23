import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Persists onboarding completion.
class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase(this._repository);

  final OnboardingRepository _repository;

  /// Marks onboarding as completed in persistence.
  Future<void> call() => _repository.markCompleted();
}
