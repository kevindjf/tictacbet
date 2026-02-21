import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tic_tac_bet/app.dart';
import 'package:tic_tac_bet/features/history/data/models/game_history_entry_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(GameHistoryEntryModelAdapter());

  await Future.wait([
    Hive.openBox<GameHistoryEntryModel>('game_history'),
    Hive.openBox('wallet'),
    Hive.openBox('onboarding'),
  ]);

  runApp(const ProviderScope(child: TicTacBetApp()));
}
