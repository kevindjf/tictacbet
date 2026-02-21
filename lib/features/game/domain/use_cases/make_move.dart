import 'package:tic_tac_bet/core/utils/result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

class MakeMoveUseCase {
  Result<Board> call(Board board, int row, int col, Player player) {
    if (row < 0 || row > 2 || col < 0 || col > 2) {
      return const Result.failure('Position out of bounds');
    }

    if (!board.isCellEmpty(row, col)) {
      return const Result.failure('Cell is already occupied');
    }

    final move = Move(row: row, col: col, player: player);
    return Result.success(board.applyMove(move));
  }
}
