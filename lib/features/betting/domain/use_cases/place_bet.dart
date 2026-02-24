import 'package:tic_tac_bet/core/utils/result.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';

class PlaceBetUseCase {
  Result<Bet> call(
    Wallet wallet,
    int amount, {
    int minimumBet = Wallet.minimumBet,
  }) {
    if (amount < minimumBet) {
      return Result.failure('Minimum bet is $minimumBet coins');
    }

    if (amount > wallet.availableBalance) {
      return const Result.failure('Insufficient balance');
    }

    return Result.success(Bet(amount: amount, multiplier: 1.0));
  }
}
