import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/core/utils/result.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/place_bet.dart';

void main() {
  late PlaceBetUseCase sut;
  late Wallet wallet;

  setUp(() {
    sut = PlaceBetUseCase();
    wallet = const Wallet(balance: 1000);
  });

  group('PlaceBetUseCase', () {
    test('returns success with correct bet for valid amount', () {
      final result = sut(wallet, 100);

      expect(result, isA<Success<Bet>>());
      final bet = (result as Success<Bet>).data;
      expect(bet.amount, 100);
      expect(bet.multiplier, 1.0);
    });

    test('returns failure when amount below minimum', () {
      final result = sut(wallet, Wallet.minimumBet - 1);
      expect(result, isA<Failure<Bet>>());
    });

    test('returns success for minimum bet', () {
      final result = sut(wallet, Wallet.minimumBet);
      expect(result, isA<Success<Bet>>());
    });

    test('returns failure when amount exceeds balance', () {
      final result = sut(wallet, 1001);
      expect(result, isA<Failure<Bet>>());
    });

    test('returns failure for zero amount', () {
      final result = sut(wallet, 0);
      expect(result, isA<Failure<Bet>>());
    });

    test('returns failure when wallet has insufficient available balance', () {
      final constrainedWallet = const Wallet(balance: 1000, frozenAmount: 950);
      final result = sut(constrainedWallet, 100);
      expect(result, isA<Failure<Bet>>());
    });

    test('returns success when amount equals available balance', () {
      final constrainedWallet = const Wallet(balance: 1000, frozenAmount: 600);
      final result = sut(constrainedWallet, 400);

      expect(result, isA<Success<Bet>>());
      expect((result as Success<Bet>).data.amount, 400);
    });

    test('returns failure when amount exceeds available balance', () {
      final constrainedWallet = const Wallet(balance: 1000, frozenAmount: 600);
      final result = sut(constrainedWallet, 401);

      expect(result, isA<Failure<Bet>>());
    });

    test('bet potentialWinnings calculated correctly', () {
      final result = sut(wallet, 200) as Success<Bet>;
      expect(result.data.potentialWinnings, 400);
    });
  });
}
