import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

part 'game_history_entry.freezed.dart';

@freezed
sealed class GameHistoryEntry with _$GameHistoryEntry {
  const factory GameHistoryEntry({
    required String id,
    required DateTime playedAt,
    required GameMode mode,
    required GameOutcome outcome,
    required Player playerSide,
    required List<Move> moves,
    int? betAmount,
    int? coinsWon,
  }) = _GameHistoryEntry;
}

enum GameOutcome { win, loss, draw }
