import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';

void main() {
  group('Wallet', () {
    test('availableBalance subtracts frozen amount', () {
      const wallet = Wallet(balance: 1000, frozenAmount: 250);

      expect(wallet.availableBalance, 750);
    });

    test('canBet validates minimum bet', () {
      const wallet = Wallet(balance: 1000);

      expect(wallet.canBet(Wallet.minimumBet - 1), isFalse);
      expect(wallet.canBet(Wallet.minimumBet), isTrue);
    });

    test('canBet validates available balance instead of total balance', () {
      const wallet = Wallet(balance: 1000, frozenAmount: 950);

      expect(wallet.canBet(60), isFalse);
      expect(wallet.canBet(50), isTrue);
    });

    test('bailoutAmount returns first bailout on first bankruptcy', () {
      const wallet = Wallet(balance: 0, bailoutCount: 0);

      expect(wallet.bailoutAmount, Wallet.firstBailout);
    });

    test('bailoutAmount returns subsequent bailout after first bailout', () {
      const wallet = Wallet(balance: 0, bailoutCount: 1);

      expect(wallet.bailoutAmount, Wallet.subsequentBailout);
    });

    test('isBankrupt is true only when balance is zero or below', () {
      const fundedWallet = Wallet(balance: 1);
      const emptyWallet = Wallet(balance: 0);
      const negativeWallet = Wallet(balance: -1);

      expect(fundedWallet.isBankrupt, isFalse);
      expect(emptyWallet.isBankrupt, isTrue);
      expect(negativeWallet.isBankrupt, isTrue);
    });
  });
}
