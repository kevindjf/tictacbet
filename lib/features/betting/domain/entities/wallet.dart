import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';

@freezed
sealed class Wallet with _$Wallet {
  const factory Wallet({
    required int balance,
    @Default(0) int frozenAmount,
    @Default(0) int bailoutCount,
  }) = _Wallet;

  const Wallet._();

  static const int initialBalance = 1000;
  static const int firstBailout = 500;
  static const int subsequentBailout = 200;
  static const int minimumBet = 10;

  int get availableBalance => balance - frozenAmount;

  bool canBet(int amount) => amount >= minimumBet && amount <= availableBalance;

  int get bailoutAmount => bailoutCount == 0 ? firstBailout : subsequentBailout;

  bool get isBankrupt => balance <= 0;
}
