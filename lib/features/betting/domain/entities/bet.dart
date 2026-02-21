import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet.freezed.dart';

@freezed
sealed class Bet with _$Bet {
  const factory Bet({required int amount, required double multiplier}) = _Bet;

  const Bet._();

  int get potentialWinnings => (amount * 2 * multiplier).round();
}
