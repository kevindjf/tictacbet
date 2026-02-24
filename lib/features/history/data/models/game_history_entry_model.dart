import 'package:hive_ce/hive.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';

part 'game_history_entry_model.g.dart';

@HiveType(typeId: 0)
class GameHistoryEntryModel extends HiveObject {
  GameHistoryEntryModel({
    required this.id,
    required this.playedAt,
    required this.modeType,
    required this.outcomeIndex,
    required this.playerSideIndex,
    required this.moveRows,
    required this.moveCols,
    required this.movePlayers,
    this.difficultyIndex,
    this.betAmount,
    this.coinsWon,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime playedAt;

  @HiveField(2)
  String modeType; // 'vsAi', 'vsLocal', 'online'

  @HiveField(3)
  int outcomeIndex; // 0=win, 1=loss, 2=draw

  @HiveField(4)
  int playerSideIndex; // 0=X, 1=O

  @HiveField(5)
  List<int> moveRows;

  @HiveField(6)
  List<int> moveCols;

  @HiveField(7)
  List<int> movePlayers;

  @HiveField(8)
  int? difficultyIndex;

  @HiveField(9)
  int? betAmount;

  @HiveField(10)
  int? coinsWon;

  GameHistoryEntry toDomain() {
    final moves = <Move>[];
    for (var i = 0; i < moveRows.length; i++) {
      moves.add(
        Move(
          row: moveRows[i],
          col: moveCols[i],
          player: Player.values[movePlayers[i]],
        ),
      );
    }

    final GameMode mode = switch (modeType) {
      'vsAi' => GameMode.vsAi(
        difficulty: Difficulty.values[difficultyIndex ?? 2],
      ),
      'online' => const GameMode.online(),
      _ => const GameMode.vsLocal(),
    };

    return GameHistoryEntry(
      id: id,
      playedAt: playedAt,
      mode: mode,
      outcome: GameOutcome.values[outcomeIndex],
      playerSide: Player.values[playerSideIndex],
      moves: moves,
      betAmount: betAmount,
      coinsWon: coinsWon,
    );
  }

}

/// Converts a domain [GameHistoryEntry] to its Hive storage model.
extension GameHistoryEntryToModel on GameHistoryEntry {
  GameHistoryEntryModel toModel() {
    String modeType;
    int? difficultyIdx;

    switch (mode) {
      case GameModeVsAi(:final difficulty):
        modeType = 'vsAi';
        difficultyIdx = difficulty.index;
      case GameModeVsLocal():
        modeType = 'vsLocal';
      case GameModeOnline():
        modeType = 'online';
    }

    return GameHistoryEntryModel(
      id: id,
      playedAt: playedAt,
      modeType: modeType,
      outcomeIndex: outcome.index,
      playerSideIndex: playerSide.index,
      moveRows: moves.map((m) => m.row).toList(),
      moveCols: moves.map((m) => m.col).toList(),
      movePlayers: moves.map((m) => m.player.index).toList(),
      difficultyIndex: difficultyIdx,
      betAmount: betAmount,
      coinsWon: coinsWon,
    );
  }
}
