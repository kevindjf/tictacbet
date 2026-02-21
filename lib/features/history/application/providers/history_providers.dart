import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/features/history/data/datasources/history_local_datasource.dart';
import 'package:tic_tac_bet/features/history/data/repositories/history_repository_impl.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_statistics.dart';
import 'package:tic_tac_bet/features/history/domain/repositories/history_repository.dart';

final historyDatasourceProvider = Provider<HistoryLocalDatasource>((ref) {
  return HistoryLocalDatasource();
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(ref.read(historyDatasourceProvider));
});

final historyProvider = FutureProvider.autoDispose<List<GameHistoryEntry>>((
  ref,
) async {
  final repository = ref.read(historyRepositoryProvider);
  return repository.getHistory();
});

final statisticsProvider = FutureProvider.autoDispose<GameStatistics>((
  ref,
) async {
  final repository = ref.read(historyRepositoryProvider);
  return repository.getStatistics();
});

final onlineStatisticsProvider = FutureProvider.autoDispose<GameStatistics>((
  ref,
) async {
  final repository = ref.read(historyRepositoryProvider);
  return repository.getStatistics(onlineOnly: true);
});
