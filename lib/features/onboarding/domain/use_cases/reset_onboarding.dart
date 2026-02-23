import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Clears onboarding completion state.
class ResetOnboardingUseCase {
  /// Resets onboarding completion flag in persistence.
  Future<void> call(OnboardingRepository repository) => repository.reset();
}
