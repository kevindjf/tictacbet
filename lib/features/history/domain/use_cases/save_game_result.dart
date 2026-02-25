import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/domain/repositories/history_repository.dart';

class SaveGameResultUseCase {
  const SaveGameResultUseCase(this._repository);

  final HistoryRepository _repository;

  Future<void> call({
    required GameMode mode,
    required GameOutcome outcome,
    required Player playerSide,
    required List<Move> moves,
    int? betAmount,
    int? coinsWon,
  }) {
    final entry = GameHistoryEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      playedAt: DateTime.now(),
      mode: mode,
      outcome: outcome,
      playerSide: playerSide,
      moves: moves,
      betAmount: betAmount,
      coinsWon: coinsWon,
    );
    return _repository.addEntry(entry);
  }
}
