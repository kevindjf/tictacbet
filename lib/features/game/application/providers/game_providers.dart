import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/core/constants/app_durations.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/ai_move.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/check_winner.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/make_move.dart';

part 'game_providers.g.dart';

@riverpod
CheckWinnerUseCase checkWinnerUseCase(Ref ref) {
  return CheckWinnerUseCase();
}

@riverpod
MakeMoveUseCase makeMoveUseCase(Ref ref) {
  return MakeMoveUseCase();
}

@riverpod
AiMoveUseCase aiMoveUseCase(Ref ref) {
  return AiMoveUseCase(checkWinner: ref.read(checkWinnerUseCaseProvider));
}

@riverpod
class GameController extends _$GameController {
  Timer? _aiTimer;

  /// Difficulty randomly assigned when an online game starts, simulating the
  /// remote opponent with an AI of unknown strength.
  Difficulty? _onlineAiDifficulty;

  CheckWinnerUseCase get _checkWinner => ref.read(checkWinnerUseCaseProvider);
  MakeMoveUseCase get _makeMove => ref.read(makeMoveUseCaseProvider);
  AiMoveUseCase get _aiMove => ref.read(aiMoveUseCaseProvider);

  @override
  GameState build() {
    ref.onDispose(() {
      _aiTimer?.cancel();
    });
    return GameState.initial(const GameMode.vsLocal());
  }

  void startGame(GameMode mode) {
    _aiTimer?.cancel();
    if (mode is GameModeOnline) {
      final difficulties = Difficulty.values;
      _onlineAiDifficulty = difficulties[Random().nextInt(difficulties.length)];
    }
    state = GameState.initial(mode);
  }

  void playMove(int row, int col) {
    if (state.isGameOver) return;
    if (state.isAiThinking) return;

    final result = _makeMove(state.board, row, col, state.currentPlayer);
    result.when(
      success: (newBoard) {
        final move = Move(row: row, col: col, player: state.currentPlayer);
        final gameResult = _checkWinner(newBoard);
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
    if (state.currentPlayer != Player.o) return;

    final Difficulty difficulty;
    if (mode is GameModeVsAi) {
      difficulty = mode.difficulty;
    } else if (mode is GameModeOnline && _onlineAiDifficulty != null) {
      difficulty = _onlineAiDifficulty!;
    } else {
      return;
    }

    state = state.copyWith(isAiThinking: true);

    _aiTimer?.cancel();
    _aiTimer = Timer(AppDurations.aiDelay, () {
      if (state.isGameOver) return;

      final aiMoveResult = _aiMove(state.board, Player.o, difficulty);
      final newBoard = state.board.applyMove(aiMoveResult);
      final gameResult = _checkWinner(newBoard);

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
}
