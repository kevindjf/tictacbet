import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_statistics.dart';

abstract class HistoryRepository {
  Future<List<GameHistoryEntry>> getHistory({bool onlineOnly = false});
  Future<void> addEntry(GameHistoryEntry entry);
  Future<GameStatistics> getStatistics({bool onlineOnly = false});
  Future<void> clearHistory();
}
