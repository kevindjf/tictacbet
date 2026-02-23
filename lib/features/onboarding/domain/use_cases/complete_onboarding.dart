import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Persists onboarding completion.
class CompleteOnboardingUseCase {
  /// Marks onboarding as completed in persistence.
  Future<void> call(OnboardingRepository repository) =>
      repository.markCompleted();
}
