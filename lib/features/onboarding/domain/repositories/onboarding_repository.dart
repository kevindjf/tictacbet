/// Contract for onboarding persistence operations.
abstract class OnboardingRepository {
  /// Returns whether the onboarding flow has been completed.
  bool isCompleted();

  /// Marks onboarding as completed.
  Future<void> markCompleted();

  /// Resets onboarding completion state.
  Future<void> reset();
}
