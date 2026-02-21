import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/domain/repositories/history_repository.dart';

class GetHistoryUseCase {
  const GetHistoryUseCase(this._repository);
  final HistoryRepository _repository;

  Future<List<GameHistoryEntry>> call({bool onlineOnly = false}) {
    return _repository.getHistory(onlineOnly: onlineOnly);
  }
}
