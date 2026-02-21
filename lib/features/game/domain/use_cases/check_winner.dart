import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';

class CheckWinnerUseCase {
  static const _lines = <List<(int, int)>>[
    // Rows
    [(0, 0), (0, 1), (0, 2)],
    [(1, 0), (1, 1), (1, 2)],
    [(2, 0), (2, 1), (2, 2)],
    // Columns
    [(0, 0), (1, 0), (2, 0)],
    [(0, 1), (1, 1), (2, 1)],
    [(0, 2), (1, 2), (2, 2)],
    // Diagonals
    [(0, 0), (1, 1), (2, 2)],
    [(0, 2), (1, 1), (2, 0)],
  ];

  GameResult call(Board board) {
    for (final line in _lines) {
      final first = board.cellAt(line[0].$1, line[0].$2);
      if (first == null) continue;

      final allSame = line.every(
        (pos) => board.cellAt(pos.$1, pos.$2) == first,
      );

      if (allSame) {
        return GameResult.win(winner: first, winningLine: line);
      }
    }

    if (board.isFull) return const GameResult.draw();

    return const GameResult.ongoing();
  }
}
