import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/core/utils/result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/make_move.dart';

void main() {
  late MakeMoveUseCase sut;

  setUp(() {
    sut = MakeMoveUseCase();
  });

  group('MakeMoveUseCase', () {
    test('returns success with updated board for valid move', () {
      final board = Board.empty();
      final result = sut(board, 1, 1, Player.x);

      expect(result, isA<Success<Board>>());
      final newBoard = (result as Success<Board>).data;
      expect(newBoard.cellAt(1, 1), Player.x);
    });

    test('returns failure when row < 0', () {
      final result = sut(Board.empty(), -1, 0, Player.x);
      expect(result, isA<Failure<Board>>());
    });

    test('returns failure when row > 2', () {
      final result = sut(Board.empty(), 3, 0, Player.x);
      expect(result, isA<Failure<Board>>());
    });

    test('returns failure when col < 0', () {
      final result = sut(Board.empty(), 0, -1, Player.x);
      expect(result, isA<Failure<Board>>());
    });

    test('returns failure when col > 2', () {
      final result = sut(Board.empty(), 0, 3, Player.x);
      expect(result, isA<Failure<Board>>());
    });

    test('returns failure when cell is already occupied', () {
      final board = Board.empty().applyMove(
        Move(row: 0, col: 0, player: Player.x),
      );
      final result = sut(board, 0, 0, Player.o);
      expect(result, isA<Failure<Board>>());
    });

    test('does not modify original board on success', () {
      final board = Board.empty();
      sut(board, 0, 0, Player.x);
      expect(board.cellAt(0, 0), isNull);
    });

    test('places the correct player', () {
      final board = Board.empty();
      final result = sut(board, 2, 2, Player.o) as Success<Board>;
      expect(result.data.cellAt(2, 2), Player.o);
    });
  });
}
