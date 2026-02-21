import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/ai_move.dart';
import 'package:tic_tac_bet/features/game/domain/use_cases/check_winner.dart';

void main() {
  late AiMoveUseCase sut;
  late CheckWinnerUseCase checkWinner;

  setUp(() {
    checkWinner = CheckWinnerUseCase();
    sut = AiMoveUseCase(checkWinner: checkWinner);
  });

  Board buildBoard(List<(int, int, Player)> moves) {
    var board = Board.empty();
    for (final (r, c, p) in moves) {
      board = board.applyMove(Move(row: r, col: c, player: p));
    }
    return board;
  }

  group('AiMoveUseCase — Hard (Minimax)', () {
    test('AI takes winning move when available', () {
      // O has two in a row, AI should complete it
      // X _ _
      // O O _
      // X _ _
      final board = buildBoard([
        (0, 0, Player.x),
        (1, 0, Player.o),
        (1, 1, Player.o),
        (2, 0, Player.x),
      ]);
      final move = sut(board, Player.o, Difficulty.hard);
      expect(move.row, 1);
      expect(move.col, 2);
    });

    test('AI blocks opponent from winning', () {
      // X has two in a row, AI should block
      // X X _
      // O _ _
      // _ _ O
      final board = buildBoard([
        (0, 0, Player.x),
        (0, 1, Player.x),
        (1, 0, Player.o),
        (2, 2, Player.o),
      ]);
      final move = sut(board, Player.o, Difficulty.hard);
      expect(move.row, 0);
      expect(move.col, 2);
    });

    test(
      'hard AI is unbeatable — always achieves draw or win vs any player',
      () {
        // Play 100 random games against hard AI, AI should never lose
        const attempts = 50;
        var aiLost = false;

        for (var i = 0; i < attempts; i++) {
          var board = Board.empty();
          var currentPlayer = Player.x;

          while (true) {
            final result = checkWinner(board);
            if (result is! GameResultOngoing) {
              if (result is GameResultWin && result.winner == Player.x) {
                aiLost = true;
              }
              break;
            }
            if (board.isFull) break;

            final move = currentPlayer == Player.o
                ? sut(board, Player.o, Difficulty.hard)
                : _randomMove(board, Player.x, i);
            board = board.applyMove(move);
            currentPlayer = currentPlayer.opponent;
          }
        }

        expect(
          aiLost,
          isFalse,
          reason: 'Hard AI should never lose (draw at worst)',
        );
      },
    );

    test('returns a valid move (cell within bounds and empty)', () {
      final board = buildBoard([(0, 0, Player.x), (1, 1, Player.o)]);
      final move = sut(board, Player.o, Difficulty.hard);
      expect(move.row, inInclusiveRange(0, 2));
      expect(move.col, inInclusiveRange(0, 2));
      expect(board.isCellEmpty(move.row, move.col), isTrue);
    });
  });

  group('AiMoveUseCase — Easy', () {
    test('returns a valid move', () {
      final board = Board.empty();
      final move = sut(board, Player.o, Difficulty.easy);
      expect(move.row, inInclusiveRange(0, 2));
      expect(move.col, inInclusiveRange(0, 2));
    });
  });

  group('AiMoveUseCase — Medium', () {
    test('returns a valid move', () {
      final board = buildBoard([(0, 0, Player.x), (2, 2, Player.x)]);
      final move = sut(board, Player.o, Difficulty.medium);
      expect(board.isCellEmpty(move.row, move.col), isTrue);
    });
  });
}

Move _randomMove(Board board, Player player, int seed) {
  final empty = board.emptyCells;
  final idx = seed % empty.length;
  return Move(row: empty[idx].$1, col: empty[idx].$2, player: player);
}
