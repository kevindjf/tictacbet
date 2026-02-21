import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/ai_move.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/check_winner.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/make_move.dart';
import 'package:tic_tac_bet/core/constants/app_durations.dart';

final checkWinnerUseCaseProvider = Provider<CheckWinnerUseCase>((ref) {
  return CheckWinnerUseCase();
});

final makeMoveUseCaseProvider = Provider<MakeMoveUseCase>((ref) {
  return MakeMoveUseCase();
});

final aiMoveUseCaseProvider = Provider<AiMoveUseCase>((ref) {
  return AiMoveUseCase(checkWinner: ref.read(checkWinnerUseCaseProvider));
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier({
    required this.checkWinner,
    required this.makeMove,
    required this.aiMove,
  }) : super(GameState.initial(const GameMode.vsLocal()));

  final CheckWinnerUseCase checkWinner;
  final MakeMoveUseCase makeMove;
  final AiMoveUseCase aiMove;

  Timer? _aiTimer;

  void startGame(GameMode mode) {
    state = GameState.initial(mode);
  }

  void playMove(int row, int col) {
    if (state.isGameOver) return;
    if (state.isAiThinking) return;

    final result = makeMove(state.board, row, col, state.currentPlayer);
    result.when(
      success: (newBoard) {
        final move = Move(row: row, col: col, player: state.currentPlayer);
        final gameResult = checkWinner(newBoard);
        state = state.copyWith(
          board: newBoard,
          currentPlayer: state.currentPlayer.opponent,
          result: gameResult,
          moves: [...state.moves, move],
        );

        if (!state.isGameOver) {
          _maybePlayAi();
        }
      },
      failure: (_) {},
    );
  }

  void _maybePlayAi() {
    final mode = state.mode;
    if (mode is! GameModeVsAi) return;
    if (state.currentPlayer != Player.o) return;

    state = state.copyWith(isAiThinking: true);

    _aiTimer?.cancel();
    _aiTimer = Timer(AppDurations.aiDelay, () {
      if (state.isGameOver) return;

      final aiMoveResult = aiMove(state.board, Player.o, mode.difficulty);
      final newBoard = state.board.applyMove(aiMoveResult);
      final gameResult = checkWinner(newBoard);

      state = state.copyWith(
        board: newBoard,
        currentPlayer: Player.x,
        result: gameResult,
        moves: [...state.moves, aiMoveResult],
        isAiThinking: false,
      );
    });
  }

  void reset() {
    _aiTimer?.cancel();
    state = GameState.initial(state.mode);
  }

  @override
  void dispose() {
    _aiTimer?.cancel();
    super.dispose();
  }
}

final gameNotifierProvider =
    StateNotifierProvider.autoDispose<GameNotifier, GameState>((ref) {
      return GameNotifier(
        checkWinner: ref.read(checkWinnerUseCaseProvider),
        makeMove: ref.read(makeMoveUseCaseProvider),
        aiMove: ref.read(aiMoveUseCaseProvider),
      );
    });
