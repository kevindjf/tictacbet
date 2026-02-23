import 'package:hive_ce/hive.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_locale.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:tic_tac_bet/features/settings/domain/repositories/settings_repository.dart';

/// Hive-backed implementation of [SettingsRepository].
class SettingsRepositoryImpl implements SettingsRepository {
  /// Creates a settings repository backed by the provided Hive box.
  const SettingsRepositoryImpl(this._box);

  /// Hive box name used for app settings persistence.
  static const String boxName = 'settings';

  static const String _themeModeKey = 'themeMode';
  static const String _difficultyKey = 'difficulty';
  static const String _localeKey = 'locale';

  /// Default theme mode used when no persisted value is found.
  static const AppThemeMode defaultThemeMode = AppThemeMode.dark;

  /// Default difficulty used when no persisted value is found.
  static const Difficulty defaultDifficulty = Difficulty.medium;

  final Box<dynamic> _box;

  @override
  AppThemeMode readThemeMode() {
    final raw = _box.get(_themeModeKey);
    return switch (raw) {
      'light' => AppThemeMode.light,
      'dark' => AppThemeMode.dark,
      'system' => AppThemeMode.system,
      _ => defaultThemeMode,
    };
  }

  @override
  Future<void> writeThemeMode(AppThemeMode mode) {
    final raw = switch (mode) {
      AppThemeMode.light => 'light',
      AppThemeMode.dark => 'dark',
      AppThemeMode.system => 'system',
    };
    return _box.put(_themeModeKey, raw);
  }

  @override
  Difficulty readDifficulty() {
    final raw = _box.get(_difficultyKey);
    if (raw is int && raw >= 0 && raw < Difficulty.values.length) {
      return Difficulty.values[raw];
    }
    return defaultDifficulty;
  }

  @override
  Future<void> writeDifficulty(Difficulty difficulty) {
    return _box.put(_difficultyKey, difficulty.index);
  }

  @override
  AppLocale? readLocale() {
    final raw = _box.get(_localeKey);
    return switch (raw) {
      'fr' => AppLocale.fr,
      'en' => AppLocale.en,
      _ => null,
    };
  }

  @override
  Future<void> writeLocale(AppLocale? locale) {
    if (locale == null) {
      return _box.delete(_localeKey);
    }
    return _box.put(_localeKey, locale.name);
  }
}
