import 'dart:math';

import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/check_winner.dart';

class AiMoveUseCase {
  AiMoveUseCase({CheckWinnerUseCase? checkWinner, Random? random})
    : _checkWinner = checkWinner ?? CheckWinnerUseCase(),
      _random = random ?? Random();

  final CheckWinnerUseCase _checkWinner;
  final Random _random;

  Move call(Board board, Player aiPlayer, Difficulty difficulty) {
    final emptyCells = board.emptyCells;
    assert(emptyCells.isNotEmpty, 'No empty cells available');

    return switch (difficulty) {
      Difficulty.easy => _easyMove(board, aiPlayer, emptyCells),
      Difficulty.medium => _mediumMove(board, aiPlayer, emptyCells),
      Difficulty.hard => _hardMove(board, aiPlayer),
    };
  }

  Move _easyMove(Board board, Player aiPlayer, List<(int, int)> emptyCells) {
    // 50% random, 50% depth-limited minimax (depth 2)
    if (_random.nextBool()) {
      return _randomMove(emptyCells, aiPlayer);
    }
    return _minimaxMove(board, aiPlayer, maxDepth: 2);
  }

  Move _mediumMove(Board board, Player aiPlayer, List<(int, int)> emptyCells) {
    // 30% random, 70% optimal
    if (_random.nextDouble() < 0.3) {
      return _randomMove(emptyCells, aiPlayer);
    }
    return _minimaxMove(board, aiPlayer);
  }

  Move _hardMove(Board board, Player aiPlayer) {
    return _minimaxMove(board, aiPlayer);
  }

  Move _randomMove(List<(int, int)> emptyCells, Player player) {
    final cell = emptyCells[_random.nextInt(emptyCells.length)];
    return Move(row: cell.$1, col: cell.$2, player: player);
  }

  Move _minimaxMove(Board board, Player aiPlayer, {int? maxDepth}) {
    var bestScore = -1000;
    Move? bestMove;

    for (final (row, col) in board.emptyCells) {
      final move = Move(row: row, col: col, player: aiPlayer);
      final newBoard = board.applyMove(move);
      final score = _minimax(
        newBoard,
        aiPlayer.opponent,
        aiPlayer,
        false,
        -1000,
        1000,
        0,
        maxDepth,
      );

      if (score > bestScore) {
        bestScore = score;
        bestMove = move;
      }
    }

    return bestMove!;
  }

  int _minimax(
    Board board,
    Player currentPlayer,
    Player aiPlayer,
    bool isMaximizing,
    int alpha,
    int beta,
    int depth,
    int? maxDepth,
  ) {
    final result = _checkWinner(board);

    return switch (result) {
      GameResultWin(:final winner) =>
        winner == aiPlayer ? 10 - depth : depth - 10,
      GameResultDraw() => 0,
      GameResultOngoing() => () {
        if (maxDepth != null && depth >= maxDepth) return 0;

        var a = alpha;
        var b = beta;

        if (isMaximizing) {
          var best = -1000;
          for (final (row, col) in board.emptyCells) {
            final move = Move(row: row, col: col, player: currentPlayer);
            final newBoard = board.applyMove(move);
            final score = _minimax(
              newBoard,
              currentPlayer.opponent,
              aiPlayer,
              false,
              a,
              b,
              depth + 1,
              maxDepth,
            );
            best = max(best, score);
            a = max(a, best);
            if (b <= a) break;
          }
          return best;
        } else {
          var best = 1000;
          for (final (row, col) in board.emptyCells) {
            final move = Move(row: row, col: col, player: currentPlayer);
            final newBoard = board.applyMove(move);
            final score = _minimax(
              newBoard,
              currentPlayer.opponent,
              aiPlayer,
              true,
              a,
              b,
              depth + 1,
              maxDepth,
            );
            best = min(best, score);
            b = min(b, best);
            if (b <= a) break;
          }
          return best;
        }
      }(),
    };
  }
}
