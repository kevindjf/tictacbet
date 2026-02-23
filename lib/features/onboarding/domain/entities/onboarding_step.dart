/// Represents each step of the onboarding flow.
///
/// Steps are ordered sequentially and end with the interactive simulation.
enum OnboardingStep {
  welcome,
  board,
  game,
  streaks,
  simulation;

  bool get isFirst => this == welcome;
  bool get isLast => this == simulation;

  OnboardingStep? get next {
    final idx = index + 1;
    return idx < values.length ? values[idx] : null;
  }

  OnboardingStep? get previous {
    final idx = index - 1;
    return idx >= 0 ? values[idx] : null;
  }
}
