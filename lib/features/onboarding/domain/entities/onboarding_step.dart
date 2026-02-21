enum OnboardingStep {
  welcome,
  board,
  game,
  betting,
  streaks;

  bool get isFirst => this == welcome;
  bool get isLast => this == streaks;

  OnboardingStep? get next {
    final idx = index + 1;
    return idx < values.length ? values[idx] : null;
  }

  OnboardingStep? get previous {
    final idx = index - 1;
    return idx >= 0 ? values[idx] : null;
  }
}
