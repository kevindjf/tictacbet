import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider, Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/features/history/data/datasources/history_local_datasource.dart';
import 'package:tic_tac_bet/features/history/data/repositories/history_repository_impl.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_statistics.dart';
import 'package:tic_tac_bet/features/history/domain/repositories/history_repository.dart';

part 'history_providers.g.dart';

final _historyDatasourceProvider = Provider<HistoryLocalDatasource>((ref) {
  return HistoryLocalDatasource();
});

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepositoryImpl(ref.read(_historyDatasourceProvider));
}

@riverpod
Future<List<GameHistoryEntry>> history(Ref ref) async {
  final repository = ref.read(historyRepositoryProvider);
  return repository.getHistory();
}

@riverpod
Future<GameStatistics> statistics(Ref ref) async {
  final repository = ref.read(historyRepositoryProvider);
  return repository.getStatistics();
}

@riverpod
Future<GameStatistics> onlineStatistics(Ref ref) async {
  final repository = ref.read(historyRepositoryProvider);
  return repository.getStatistics(onlineOnly: true);
}
