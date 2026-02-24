import 'package:tic_tac_bet/features/history/data/datasources/history_local_datasource.dart';
import 'package:tic_tac_bet/features/history/data/models/game_history_entry_model.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_statistics.dart';
import 'package:tic_tac_bet/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._datasource);
  final HistoryLocalDatasource _datasource;

  @override
  Future<List<GameHistoryEntry>> getHistory({bool onlineOnly = false}) async {
    final models = onlineOnly
        ? await _datasource.getByMode('online')
        : await _datasource.getAll();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<void> addEntry(GameHistoryEntry entry) async {
    await _datasource.add(GameHistoryEntryModel.fromDomain(entry));
  }

  @override
  Future<GameStatistics> getStatistics({bool onlineOnly = false}) async {
    final entries = await getHistory(onlineOnly: onlineOnly);
    return GameStatistics.fromEntries(entries);
  }

  @override
  Future<void> clearHistory() async {
    await _datasource.clear();
  }
}
