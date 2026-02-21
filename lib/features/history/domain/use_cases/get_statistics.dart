import 'package:tic_tac_bet/features/history/domain/entities/game_statistics.dart';
import 'package:tic_tac_bet/features/history/domain/repositories/history_repository.dart';

class GetStatisticsUseCase {
  const GetStatisticsUseCase(this._repository);
  final HistoryRepository _repository;

  Future<GameStatistics> call({bool onlineOnly = false}) {
    return _repository.getStatistics(onlineOnly: onlineOnly);
  }
}
