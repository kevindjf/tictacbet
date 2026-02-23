import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Returns whether onboarding has already been completed.
class CheckOnboardingCompletedUseCase {
  /// Evaluates onboarding completion state from the repository.
  bool call(OnboardingRepository repository) => repository.isCompleted();
}
