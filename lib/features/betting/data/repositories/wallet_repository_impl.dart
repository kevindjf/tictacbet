import 'package:tic_tac_bet/features/betting/data/datasources/wallet_local_datasource.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl(this._datasource);
  final WalletLocalDatasource _datasource;

  @override
  Future<Wallet> getWallet() async {
    return Wallet(
      balance: _datasource.getBalance(),
      bailoutCount: _datasource.getBailoutCount(),
    );
  }

  @override
  Future<void> updateBalance(int newBalance) async {
    await _datasource.setBalance(newBalance);
  }

  @override
  Future<void> applyBailout() async {
    final wallet = await getWallet();
    final bailoutAmount = wallet.bailoutAmount;
    await _datasource.setBalance(wallet.balance + bailoutAmount);
    await _datasource.setBailoutCount(wallet.bailoutCount + 1);
  }
}
