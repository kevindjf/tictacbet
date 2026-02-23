import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Returns whether onboarding has already been completed.
class CheckOnboardingCompletedUseCase {
  const CheckOnboardingCompletedUseCase(this._repository);

  final OnboardingRepository _repository;

  /// Evaluates onboarding completion state from the repository.
  bool call() => _repository.isCompleted();
}
