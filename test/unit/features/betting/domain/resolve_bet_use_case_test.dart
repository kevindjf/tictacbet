import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/resolve_bet.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';

void main() {
  late ResolveBetUseCase sut;

  setUp(() {
    sut = ResolveBetUseCase();
  });

  group('ResolveBetUseCase', () {
    final bet = const Bet(amount: 100, multiplier: 1.0);

    group('win', () {
      test('balance change equals full payout', () {
        final resolution = sut(bet, GameOutcome.win, 0);
        expect(resolution.balanceChange, 200); // 100 * 2 * 1.0
      });

      test('increments streak count', () {
        final resolution = sut(bet, GameOutcome.win, 2);
        expect(resolution.newStreakCount, 3);
      });

      test('win with streak multiplier 1.5x', () {
        final streakBet = const Bet(amount: 100, multiplier: 1.5);
        final resolution = sut(streakBet, GameOutcome.win, 0);
        expect(resolution.balanceChange, 300); // 100 * 2 * 1.5
      });

      test('win with 2x multiplier', () {
        final bigBet = const Bet(amount: 500, multiplier: 2.0);
        final resolution = sut(bigBet, GameOutcome.win, 3);
        expect(resolution.balanceChange, 2000); // 500 * 2 * 2.0
      });
    });

    group('loss', () {
      test('balance change is 0 (bet already deducted)', () {
        final resolution = sut(bet, GameOutcome.loss, 5);
        expect(resolution.balanceChange, 0);
      });

      test('resets streak count to 0', () {
        final resolution = sut(bet, GameOutcome.loss, 5);
        expect(resolution.newStreakCount, 0);
      });
    });

    group('draw', () {
      test('refunds the bet amount', () {
        final resolution = sut(bet, GameOutcome.draw, 0);
        expect(resolution.balanceChange, 100); // refund
      });

      test('resets streak count to 0', () {
        final resolution = sut(bet, GameOutcome.draw, 3);
        expect(resolution.newStreakCount, 0);
      });
    });
  });
}
