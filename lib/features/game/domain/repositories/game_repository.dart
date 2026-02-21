import 'package:tic_tac_bet/features/game/domain/entities/move.dart';

abstract class GameSessionRepository {
  Stream<Move> get opponentMoves;
  Future<void> sendMove(Move move);
  Future<void> dispose();
}
