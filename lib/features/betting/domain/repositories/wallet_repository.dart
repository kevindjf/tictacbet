import 'package:tic_tac_bet/features/betting/domain/entities/streak.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';

abstract class WalletRepository {
  Future<Wallet> getWallet();
  Future<void> updateBalance(int newBalance);
  Future<Streak> getStreak();
  Future<void> updateStreak(Streak streak);
  Future<void> applyBailout();
}
