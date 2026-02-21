import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

part 'move.freezed.dart';

@freezed
sealed class Move with _$Move {
  const factory Move({
    required int row,
    required int col,
    required Player player,
  }) = _Move;
}
