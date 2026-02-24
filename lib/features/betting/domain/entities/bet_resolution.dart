import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet_resolution.freezed.dart';

@freezed
sealed class BetResolution with _$BetResolution {
  const factory BetResolution({required int balanceChange}) = _BetResolution;
}
