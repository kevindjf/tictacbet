import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/betting/data/datasources/wallet_local_datasource.dart';
import 'package:tic_tac_bet/features/betting/data/repositories/wallet_repository_impl.dart';

class _FakeWalletLocalDatasource extends WalletLocalDatasource {
  int balance = 1000;
  int bailoutCount = 0;

  @override
  int getBalance() => balance;

  @override
  Future<void> setBalance(int balance) async {
    this.balance = balance;
  }

  @override
  int getBailoutCount() => bailoutCount;

  @override
  Future<void> setBailoutCount(int count) async {
    bailoutCount = count;
  }
}

void main() {
  group('WalletRepositoryImpl', () {
    late _FakeWalletLocalDatasource datasource;
    late WalletRepositoryImpl sut;

    setUp(() {
      datasource = _FakeWalletLocalDatasource();
      sut = WalletRepositoryImpl(datasource);
    });

    test('getWallet maps datasource values', () async {
      datasource.balance = 420;
      datasource.bailoutCount = 2;

      final wallet = await sut.getWallet();

      expect(wallet.balance, 420);
      expect(wallet.bailoutCount, 2);
    });

    test('updateBalance writes balance to datasource', () async {
      await sut.updateBalance(777);

      expect(datasource.balance, 777);
    });

    test(
      'applyBailout adds first bailout amount and increments count',
      () async {
        datasource.balance = 0;
        datasource.bailoutCount = 0;

        await sut.applyBailout();

        expect(datasource.balance, 500);
        expect(datasource.bailoutCount, 1);
      },
    );

    test('applyBailout adds subsequent bailout to existing balance', () async {
      datasource.balance = 120;
      datasource.bailoutCount = 1;

      await sut.applyBailout();

      expect(datasource.balance, 320);
      expect(datasource.bailoutCount, 2);
    });
  });
}
