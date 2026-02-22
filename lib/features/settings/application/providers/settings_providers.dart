import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';

part 'settings_providers.g.dart';

abstract final class SettingsStorage {
  static const _boxName = 'settings';
  static const _themeModeKey = 'themeMode';
  static const _difficultyKey = 'difficulty';
  static const _localeKey = 'locale';

  static Box<dynamic> get _box => Hive.box(_boxName);

  static ThemeMode readThemeMode() {
    final raw = _box.get(_themeModeKey);
    return switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark,
    };
  }

  static Future<void> writeThemeMode(ThemeMode mode) {
    final raw = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    return _box.put(_themeModeKey, raw);
  }

  static Difficulty readDifficulty() {
    final raw = _box.get(_difficultyKey);
    if (raw is int && raw >= 0 && raw < Difficulty.values.length) {
      return Difficulty.values[raw];
    }
    return Difficulty.medium;
  }

  static Future<void> writeDifficulty(Difficulty difficulty) {
    return _box.put(_difficultyKey, difficulty.index);
  }

  static Locale? readLocale() {
    final raw = _box.get(_localeKey);
    return switch (raw) {
      'fr' => const Locale('fr'),
      'en' => const Locale('en'),
      _ => null,
    };
  }

  static Future<void> writeLocale(Locale locale) {
    return _box.put(_localeKey, locale.languageCode);
  }
}

@Riverpod(keepAlive: true)
class ThemeModeSetting extends _$ThemeModeSetting {
  @override
  ThemeMode build() => SettingsStorage.readThemeMode();

  void setValue(ThemeMode mode) => state = mode;
}

@Riverpod(keepAlive: true)
class DifficultySetting extends _$DifficultySetting {
  @override
  Difficulty build() => SettingsStorage.readDifficulty();

  void setValue(Difficulty difficulty) => state = difficulty;
}

@Riverpod(keepAlive: true)
class LocaleSetting extends _$LocaleSetting {
  @override
  Locale? build() => SettingsStorage.readLocale();

  void setValue(Locale? locale) => state = locale;
}
