import 'package:hive_ce/hive.dart';
import 'package:tic_tac_bet/features/history/data/models/game_history_entry_model.dart';

class HistoryLocalDatasource {
  static const String boxName = 'game_history';
  static const String onlineModeKey = 'online';

  Box<GameHistoryEntryModel> get _box {
    if (!Hive.isBoxOpen(boxName)) {
      throw StateError(
        'Hive box "$boxName" is not open. Initialize and open it before using HistoryLocalDatasource.',
      );
    }
    return Hive.box<GameHistoryEntryModel>(boxName);
  }

  Future<List<GameHistoryEntryModel>> getAll() async {
    return _box.values.toList()
      ..sort((a, b) => b.playedAt.compareTo(a.playedAt));
  }

  Future<List<GameHistoryEntryModel>> getByMode(String modeType) async {
    return _box.values.where((e) => e.modeType == modeType).toList()
      ..sort((a, b) => b.playedAt.compareTo(a.playedAt));
  }

  Future<void> add(GameHistoryEntryModel entry) async {
    await _box.put(entry.id, entry);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
