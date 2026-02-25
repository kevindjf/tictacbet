import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider, Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/features/history/data/datasources/history_local_datasource.dart';
import 'package:tic_tac_bet/features/history/data/repositories/history_repository_impl.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_statistics.dart';
import 'package:tic_tac_bet/features/history/domain/repositories/history_repository.dart';
import 'package:tic_tac_bet/features/history/domain/use_cases/get_history.dart';
import 'package:tic_tac_bet/features/history/domain/use_cases/get_statistics.dart';
import 'package:tic_tac_bet/features/history/domain/use_cases/save_game_result.dart';

part 'history_providers.g.dart';

final _historyDatasourceProvider = Provider<HistoryLocalDatasource>((ref) {
  return HistoryLocalDatasource();
});

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepositoryImpl(ref.read(_historyDatasourceProvider));
}

@Riverpod(keepAlive: true)
GetHistoryUseCase getHistoryUseCase(Ref ref) {
  return GetHistoryUseCase(ref.read(historyRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetStatisticsUseCase getStatisticsUseCase(Ref ref) {
  return GetStatisticsUseCase(ref.read(historyRepositoryProvider));
}

@Riverpod(keepAlive: true)
SaveGameResultUseCase saveGameResultUseCase(Ref ref) {
  return SaveGameResultUseCase(ref.read(historyRepositoryProvider));
}

@riverpod
Future<List<GameHistoryEntry>> history(Ref ref) async {
  return ref.read(getHistoryUseCaseProvider)();
}

@riverpod
Future<GameStatistics> statistics(Ref ref, {required bool onlineOnly}) async {
  return ref.read(getStatisticsUseCaseProvider)(onlineOnly: onlineOnly);
}
