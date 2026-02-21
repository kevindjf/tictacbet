import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

final difficultyProvider = StateProvider<Difficulty>(
  (ref) => Difficulty.medium,
);

final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));
