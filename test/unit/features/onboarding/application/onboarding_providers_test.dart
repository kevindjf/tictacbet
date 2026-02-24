import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/features/onboarding/application/providers/onboarding_providers.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';
import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';

class _FakeOnboardingRepository implements OnboardingRepository {
  bool completed;

  _FakeOnboardingRepository({this.completed = false});

  @override
  bool isCompleted() => completed;

  @override
  Future<void> markCompleted() async {
    completed = true;
  }

  @override
  Future<void> reset() async {
    completed = false;
  }
}

void main() {
  group('onboarding providers', () {
    test('OnboardingCompleted reads persisted state from repository', () {
      final fakeRepository = _FakeOnboardingRepository(completed: true);
      final container = ProviderContainer(
        overrides: [
          onboardingRepositoryProvider.overrideWith((ref) => fakeRepository),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(onboardingCompletedProvider), isTrue);
    });

    test(
      'OnboardingController follows start -> next -> complete cycle',
      () async {
        final fakeRepository = _FakeOnboardingRepository();
        final container = ProviderContainer(
          overrides: [
            onboardingRepositoryProvider.overrideWith((ref) => fakeRepository),
          ],
        );
        addTearDown(container.dispose);

        final controller = container.read(
          onboardingControllerProvider.notifier,
        );

        expect(container.read(onboardingControllerProvider), isNull);

        controller.start();
        expect(
          container.read(onboardingControllerProvider),
          OnboardingStep.welcome,
        );

        await controller.next();
        expect(
          container.read(onboardingControllerProvider),
          OnboardingStep.board,
        );

        await controller.next();
        await controller.next();
        expect(
          container.read(onboardingControllerProvider),
          OnboardingStep.simulation,
        );

        await controller.next();
        expect(container.read(onboardingControllerProvider), isNull);
        expect(fakeRepository.completed, isTrue);
      },
    );

    test('skip completes onboarding and reset clears persisted flag', () async {
      final fakeRepository = _FakeOnboardingRepository();
      final container = ProviderContainer(
        overrides: [
          onboardingRepositoryProvider.overrideWith((ref) => fakeRepository),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(onboardingControllerProvider.notifier);
      controller.start();

      await controller.skip();
      expect(container.read(onboardingControllerProvider), isNull);
      expect(fakeRepository.completed, isTrue);

      await controller.reset();
      expect(fakeRepository.completed, isFalse);
    });
  });
}
