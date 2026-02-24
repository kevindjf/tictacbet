import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/core/entities/game_outcome.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/resolve_bet.dart';

void main() {
  late ResolveBetUseCase sut;

  setUp(() {
    sut = ResolveBetUseCase();
  });

  group('ResolveBetUseCase', () {
    final bet = const Bet(amount: 100, multiplier: 1.0);

    group('win', () {
      test('balance change equals full payout', () {
        final resolution = sut(bet, GameOutcome.win);
        expect(resolution.balanceChange, 200);
      });

      test('win with custom multiplier still pays correctly', () {
        final customMultiplierBet = const Bet(amount: 100, multiplier: 1.5);
        final resolution = sut(customMultiplierBet, GameOutcome.win);
        expect(resolution.balanceChange, 300);
      });
    });

    group('loss', () {
      test('balance change is 0 (bet already deducted)', () {
        final resolution = sut(bet, GameOutcome.loss);
        expect(resolution.balanceChange, 0);
      });
    });

    group('draw', () {
      test('refunds the bet amount', () {
        final resolution = sut(bet, GameOutcome.draw);
        expect(resolution.balanceChange, 100);
      });
    });
  });
}
