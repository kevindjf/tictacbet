import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

void main() {
  group('Board', () {
    group('Board.empty()', () {
      test('creates a 3x3 grid with all null cells', () {
        final board = Board.empty();
        for (var r = 0; r < 3; r++) {
          for (var c = 0; c < 3; c++) {
            expect(board.cellAt(r, c), isNull);
          }
        }
      });

      test('is not full', () {
        expect(Board.empty().isFull, isFalse);
      });

      test('has 9 empty cells', () {
        expect(Board.empty().emptyCells.length, 9);
      });

      test('has moveCount 0', () {
        expect(Board.empty().moveCount, 0);
      });
    });

    group('applyMove()', () {
      test('places player on correct cell', () {
        final board = Board.empty();
        final move = Move(row: 1, col: 2, player: Player.x);
        final newBoard = board.applyMove(move);

        expect(newBoard.cellAt(1, 2), Player.x);
      });

      test('does not mutate the original board', () {
        final board = Board.empty();
        final move = Move(row: 0, col: 0, player: Player.x);
        board.applyMove(move);

        expect(board.cellAt(0, 0), isNull);
      });

      test('returns new board with all other cells unchanged', () {
        final board = Board.empty();
        final move = Move(row: 1, col: 1, player: Player.o);
        final newBoard = board.applyMove(move);

        for (var r = 0; r < 3; r++) {
          for (var c = 0; c < 3; c++) {
            if (r == 1 && c == 1) {
              expect(newBoard.cellAt(r, c), Player.o);
            } else {
              expect(newBoard.cellAt(r, c), isNull);
            }
          }
        }
      });

      test('increments moveCount', () {
        final board = Board.empty();
        final move = Move(row: 0, col: 0, player: Player.x);
        final newBoard = board.applyMove(move);

        expect(newBoard.moveCount, 1);
      });
    });

    group('isFull', () {
      test('returns true when all cells are filled', () {
        var board = Board.empty();
        final moves = [
          Move(row: 0, col: 0, player: Player.x),
          Move(row: 0, col: 1, player: Player.o),
          Move(row: 0, col: 2, player: Player.x),
          Move(row: 1, col: 0, player: Player.o),
          Move(row: 1, col: 1, player: Player.x),
          Move(row: 1, col: 2, player: Player.o),
          Move(row: 2, col: 0, player: Player.x),
          Move(row: 2, col: 1, player: Player.o),
          Move(row: 2, col: 2, player: Player.x),
        ];
        for (final move in moves) {
          board = board.applyMove(move);
        }
        expect(board.isFull, isTrue);
      });
    });

    group('isCellEmpty()', () {
      test('returns true for empty cell', () {
        expect(Board.empty().isCellEmpty(0, 0), isTrue);
      });

      test('returns false after placing a player', () {
        final board = Board.empty().applyMove(
          Move(row: 0, col: 0, player: Player.x),
        );
        expect(board.isCellEmpty(0, 0), isFalse);
      });
    });

    group('emptyCells', () {
      test('decreases after each move', () {
        var board = Board.empty();
        expect(board.emptyCells.length, 9);

        board = board.applyMove(Move(row: 0, col: 0, player: Player.x));
        expect(board.emptyCells.length, 8);

        board = board.applyMove(Move(row: 1, col: 1, player: Player.o));
        expect(board.emptyCells.length, 7);
      });

      test('does not include occupied cells', () {
        final board = Board.empty().applyMove(
          Move(row: 1, col: 1, player: Player.x),
        );
        final empty = board.emptyCells;
        expect(empty.contains((1, 1)), isFalse);
      });
    });
  });
}
