import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/check_winner.dart';

void main() {
  late CheckWinnerUseCase sut;

  setUp(() {
    sut = CheckWinnerUseCase();
  });

  Board buildBoard(List<(int, int, Player)> moves) {
    var board = Board.empty();
    for (final (r, c, p) in moves) {
      board = board.applyMove(Move(row: r, col: c, player: p));
    }
    return board;
  }

  group('CheckWinnerUseCase', () {
    group('ongoing game', () {
      test('returns ongoing on empty board', () {
        final result = sut(Board.empty());
        expect(result, isA<GameResultOngoing>());
      });

      test('returns ongoing when no winner yet', () {
        final board = buildBoard([(0, 0, Player.x), (1, 1, Player.o)]);
        expect(sut(board), isA<GameResultOngoing>());
      });
    });

    group('row wins', () {
      test('X wins top row', () {
        final board = buildBoard([
          (0, 0, Player.x),
          (0, 1, Player.x),
          (0, 2, Player.x),
        ]);
        final result = sut(board);
        expect(result, isA<GameResultWin>());
        expect((result as GameResultWin).winner, Player.x);
      });

      test('O wins middle row', () {
        final board = buildBoard([
          (1, 0, Player.o),
          (1, 1, Player.o),
          (1, 2, Player.o),
        ]);
        final result = sut(board);
        expect(result, isA<GameResultWin>());
        expect((result as GameResultWin).winner, Player.o);
      });

      test('X wins bottom row', () {
        final board = buildBoard([
          (2, 0, Player.x),
          (2, 1, Player.x),
          (2, 2, Player.x),
        ]);
        expect((sut(board) as GameResultWin).winner, Player.x);
      });
    });

    group('column wins', () {
      test('X wins left column', () {
        final board = buildBoard([
          (0, 0, Player.x),
          (1, 0, Player.x),
          (2, 0, Player.x),
        ]);
        expect((sut(board) as GameResultWin).winner, Player.x);
      });

      test('O wins middle column', () {
        final board = buildBoard([
          (0, 1, Player.o),
          (1, 1, Player.o),
          (2, 1, Player.o),
        ]);
        expect((sut(board) as GameResultWin).winner, Player.o);
      });

      test('X wins right column', () {
        final board = buildBoard([
          (0, 2, Player.x),
          (1, 2, Player.x),
          (2, 2, Player.x),
        ]);
        expect((sut(board) as GameResultWin).winner, Player.x);
      });
    });

    group('diagonal wins', () {
      test('X wins main diagonal (top-left to bottom-right)', () {
        final board = buildBoard([
          (0, 0, Player.x),
          (1, 1, Player.x),
          (2, 2, Player.x),
        ]);
        final result = sut(board) as GameResultWin;
        expect(result.winner, Player.x);
        expect(result.winningLine, containsAll([(0, 0), (1, 1), (2, 2)]));
      });

      test('O wins anti-diagonal (top-right to bottom-left)', () {
        final board = buildBoard([
          (0, 2, Player.o),
          (1, 1, Player.o),
          (2, 0, Player.o),
        ]);
        final result = sut(board) as GameResultWin;
        expect(result.winner, Player.o);
      });
    });

    group('draw', () {
      test('returns draw when board is full with no winner', () {
        // X O X
        // X X O
        // O X O
        final board = buildBoard([
          (0, 0, Player.x),
          (0, 1, Player.o),
          (0, 2, Player.x),
          (1, 0, Player.x),
          (1, 1, Player.x),
          (1, 2, Player.o),
          (2, 0, Player.o),
          (2, 1, Player.x),
          (2, 2, Player.o),
        ]);
        expect(sut(board), isA<GameResultDraw>());
      });
    });

    group('winningLine', () {
      test('contains exactly 3 cells', () {
        final board = buildBoard([
          (0, 0, Player.x),
          (0, 1, Player.x),
          (0, 2, Player.x),
        ]);
        final result = sut(board) as GameResultWin;
        expect(result.winningLine.length, 3);
      });
    });
  });
}
