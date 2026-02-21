import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/core/utils/result.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/streak.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/place_bet.dart';

void main() {
  late PlaceBetUseCase sut;
  late Wallet wallet;
  late Streak noStreak;

  setUp(() {
    sut = PlaceBetUseCase();
    wallet = const Wallet(balance: 1000);
    noStreak = const Streak();
  });

  group('PlaceBetUseCase', () {
    test('returns success with correct bet for valid amount', () {
      final result = sut(wallet, 100, noStreak);

      expect(result, isA<Success<Bet>>());
      final bet = (result as Success<Bet>).data;
      expect(bet.amount, 100);
      expect(bet.multiplier, 1.0);
    });

    test('returns failure when amount below minimum', () {
      final result = sut(wallet, Wallet.minimumBet - 1, noStreak);
      expect(result, isA<Failure<Bet>>());
    });

    test('returns success for minimum bet', () {
      final result = sut(wallet, Wallet.minimumBet, noStreak);
      expect(result, isA<Success<Bet>>());
    });

    test('returns failure when amount exceeds balance', () {
      final result = sut(wallet, 1001, noStreak);
      expect(result, isA<Failure<Bet>>());
    });

    test('returns failure for zero amount', () {
      final result = sut(wallet, 0, noStreak);
      expect(result, isA<Failure<Bet>>());
    });

    test('includes streak multiplier in bet', () {
      final streak = const Streak(count: 3); // 2x multiplier
      final result = sut(wallet, 100, streak) as Success<Bet>;
      expect(result.data.multiplier, 2.0);
    });

    test('returns failure when wallet has insufficient available balance', () {
      // Balance 1000, frozen 950, available 50
      final constrainedWallet = const Wallet(balance: 1000, frozenAmount: 950);
      final result = sut(constrainedWallet, 100, noStreak);
      expect(result, isA<Failure<Bet>>());
    });

    test('bet potentialWinnings calculated correctly', () {
      final result = sut(wallet, 200, noStreak) as Success<Bet>;
      expect(result.data.potentialWinnings, 400); // 200 * 2 * 1.0
    });

    test('bet potentialWinnings with streak multiplier', () {
      final streak = const Streak(count: 2); // 1.5x
      final result = sut(wallet, 100, streak) as Success<Bet>;
      expect(result.data.potentialWinnings, 300); // 100 * 2 * 1.5
    });
  });
}
