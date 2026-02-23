import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tic_tac_bet/features/history/data/models/game_history_entry_model.dart';

/// Bootstraps Hive storage for the app.
///
/// Registers adapters and opens all boxes required at startup.
abstract final class HiveInitializer {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(GameHistoryEntryModelAdapter());

    await Future.wait([
      Hive.openBox<GameHistoryEntryModel>('game_history'),
      Hive.openBox('wallet'),
      Hive.openBox('onboarding'),
      Hive.openBox('settings'),
    ]);
  }
}
