import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';

void main() {
  group('OnboardingStep', () {
    test('next returns the following step in order', () {
      expect(OnboardingStep.welcome.next, OnboardingStep.board);
      expect(OnboardingStep.board.next, OnboardingStep.game);
      expect(OnboardingStep.game.next, OnboardingStep.simulation);
      expect(OnboardingStep.simulation.next, isNull);
    });

    test('previous returns the previous step in order', () {
      expect(OnboardingStep.welcome.previous, isNull);
      expect(OnboardingStep.board.previous, OnboardingStep.welcome);
      expect(OnboardingStep.game.previous, OnboardingStep.board);
      expect(OnboardingStep.simulation.previous, OnboardingStep.game);
    });

    test('isFirst and isLast flags are correct', () {
      expect(OnboardingStep.welcome.isFirst, isTrue);
      expect(OnboardingStep.welcome.isLast, isFalse);
      expect(OnboardingStep.simulation.isFirst, isFalse);
      expect(OnboardingStep.simulation.isLast, isTrue);
      expect(OnboardingStep.game.isFirst, isFalse);
      expect(OnboardingStep.game.isLast, isFalse);
    });
  });
}
