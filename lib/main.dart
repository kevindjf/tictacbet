import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/app.dart';
import 'package:tic_tac_bet/core/services/hive_initializer.dart';

/// Application entry point.
///
/// Initializes Hive local storage (adapters and required boxes) and launches
/// the app inside a Riverpod [ProviderScope].
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitializer.initialize();

  runApp(const ProviderScope(child: TicTacBetApp()));
}
