import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tic_tac_bet/features/onboarding/data/repositories/onboarding_repository_impl.dart';

class _MockBox extends Mock implements Box<dynamic> {}

void main() {
  late _MockBox box;
  late OnboardingRepositoryImpl repository;

  setUp(() {
    box = _MockBox();
    repository = OnboardingRepositoryImpl(box);
  });

  group('OnboardingRepositoryImpl', () {
    test('isCompleted returns false when missing or invalid value', () {
      when(() => box.get('completed', defaultValue: false)).thenReturn(null);
      expect(repository.isCompleted(), isFalse);

      when(() => box.get('completed', defaultValue: false)).thenReturn('yes');
      expect(repository.isCompleted(), isFalse);
    });

    test('isCompleted returns true only for bool true', () {
      when(() => box.get('completed', defaultValue: false)).thenReturn(true);
      expect(repository.isCompleted(), isTrue);
    });

    test('markCompleted persists true', () async {
      when(() => box.put('completed', true)).thenAnswer((_) async {});

      await repository.markCompleted();

      verify(() => box.put('completed', true)).called(1);
    });

    test('reset persists false', () async {
      when(() => box.put('completed', false)).thenAnswer((_) async {});

      await repository.reset();

      verify(() => box.put('completed', false)).called(1);
    });
  });
}
