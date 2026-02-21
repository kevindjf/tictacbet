import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

part 'game_result.freezed.dart';

@freezed
sealed class GameResult with _$GameResult {
  const factory GameResult.ongoing() = GameResultOngoing;
  const factory GameResult.win({
    required Player winner,
    required List<(int, int)> winningLine,
  }) = GameResultWin;
  const factory GameResult.draw() = GameResultDraw;
}
