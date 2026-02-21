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
    if (entries.isEmpty) return const GameStatistics();

    var wins = 0;
    var losses = 0;
    var draws = 0;
    var totalCoinsWon = 0;
    var totalCoinsLost = 0;
    var bestStreak = 0;
    var currentStreak = 0;

    for (final entry in entries.reversed) {
      switch (entry.outcome) {
        case GameOutcome.win:
          wins++;
          currentStreak++;
          if (currentStreak > bestStreak) bestStreak = currentStreak;
          if (entry.coinsWon != null) totalCoinsWon += entry.coinsWon!;
        case GameOutcome.loss:
          losses++;
          currentStreak = 0;
          if (entry.betAmount != null) totalCoinsLost += entry.betAmount!;
        case GameOutcome.draw:
          draws++;
          currentStreak = 0;
      }
    }

    return GameStatistics(
      totalGames: entries.length,
      wins: wins,
      losses: losses,
      draws: draws,
      totalCoinsWon: totalCoinsWon,
      totalCoinsLost: totalCoinsLost,
      bestStreak: bestStreak,
    );
  }

  @override
  Future<void> clearHistory() async {
    await _datasource.clear();
  }
}
