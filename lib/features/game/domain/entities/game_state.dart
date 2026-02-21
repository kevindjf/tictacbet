import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

part 'game_state.freezed.dart';

@freezed
sealed class GameState with _$GameState {
  const factory GameState({
    required Board board,
    required Player currentPlayer,
    required GameResult result,
    required GameMode mode,
    required List<Move> moves,
    @Default(false) bool isAiThinking,
  }) = _GameState;

  const GameState._();

  factory GameState.initial(GameMode mode) => GameState(
    board: Board.empty(),
    currentPlayer: Player.x,
    result: const GameResult.ongoing(),
    mode: mode,
    moves: const [],
  );

  bool get isGameOver => result is! GameResultOngoing;
}
