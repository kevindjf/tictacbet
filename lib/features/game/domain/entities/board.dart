import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

part 'board.freezed.dart';

@freezed
sealed class Board with _$Board {
  const factory Board({required List<List<Player?>> cells}) = _Board;

  const Board._();

  factory Board.empty() => const Board(
    cells: [
      [null, null, null],
      [null, null, null],
      [null, null, null],
    ],
  );

  Player? cellAt(int row, int col) => cells[row][col];

  bool isCellEmpty(int row, int col) => cells[row][col] == null;

  bool get isFull {
    for (final row in cells) {
      for (final cell in row) {
        if (cell == null) return false;
      }
    }
    return true;
  }

  int get moveCount {
    var count = 0;
    for (final row in cells) {
      for (final cell in row) {
        if (cell != null) count++;
      }
    }
    return count;
  }

  Board applyMove(Move move) {
    assert(isCellEmpty(move.row, move.col), 'Cell is not empty');
    final newCells = [
      for (var r = 0; r < 3; r++)
        [
          for (var c = 0; c < 3; c++)
            if (r == move.row && c == move.col) move.player else cells[r][c],
        ],
    ];
    return Board(cells: newCells);
  }

  List<(int row, int col)> get emptyCells {
    final result = <(int, int)>[];
    for (var r = 0; r < 3; r++) {
      for (var c = 0; c < 3; c++) {
        if (cells[r][c] == null) result.add((r, c));
      }
    }
    return result;
  }
}
