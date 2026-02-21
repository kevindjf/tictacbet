import 'package:tic_tac_bet/core/utils/result.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/streak.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';

class PlaceBetUseCase {
  Result<Bet> call(Wallet wallet, int amount, Streak streak) {
    if (amount < Wallet.minimumBet) {
      return Result.failure('Minimum bet is ${Wallet.minimumBet} coins');
    }

    if (!wallet.canBet(amount)) {
      return const Result.failure('Insufficient balance');
    }

    return Result.success(Bet(amount: amount, multiplier: streak.multiplier));
  }
}
