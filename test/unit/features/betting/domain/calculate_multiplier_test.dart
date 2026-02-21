import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/streak.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/calculate_multiplier.dart';

void main() {
  late CalculateMultiplierUseCase sut;

  setUp(() {
    sut = CalculateMultiplierUseCase();
  });

  group('CalculateMultiplierUseCase', () {
    test('streak 0 → multiplier 1.0', () {
      expect(sut(const Streak(count: 0)), 1.0);
    });

    test('streak 1 → multiplier 1.2', () {
      expect(sut(const Streak(count: 1)), 1.2);
    });

    test('streak 2 → multiplier 1.5', () {
      expect(sut(const Streak(count: 2)), 1.5);
    });

    test('streak 3 → multiplier 2.0', () {
      expect(sut(const Streak(count: 3)), 2.0);
    });

    test('streak 4 → multiplier 2.5', () {
      expect(sut(const Streak(count: 4)), 2.5);
    });

    test('streak 5+ → multiplier 3.0', () {
      expect(sut(const Streak(count: 5)), 3.0);
      expect(sut(const Streak(count: 10)), 3.0);
    });

    test('streak increment works correctly', () {
      final streak = const Streak(count: 2);
      final incremented = streak.increment();
      expect(incremented.count, 3);
      expect(incremented.multiplier, 2.0);
    });

    test('streak reset returns count 0', () {
      final streak = const Streak(count: 5);
      final reset = streak.reset();
      expect(reset.count, 0);
      expect(reset.multiplier, 1.0);
    });
  });
}
