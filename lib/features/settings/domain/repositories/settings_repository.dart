import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_locale.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_theme_mode.dart';

/// Contract for reading and persisting user settings.
abstract class SettingsRepository {
  /// Returns the persisted theme mode or a safe default when storage is invalid.
  AppThemeMode readThemeMode();

  /// Persists the selected theme mode.
  Future<void> writeThemeMode(AppThemeMode mode);

  /// Returns the persisted AI difficulty or a safe default when storage is invalid.
  Difficulty readDifficulty();

  /// Persists the selected AI difficulty.
  Future<void> writeDifficulty(Difficulty difficulty);

  /// Returns the persisted locale override, or `null` to follow the system locale.
  AppLocale? readLocale();

  /// Persists the locale override, or clears it when `locale` is `null`.
  Future<void> writeLocale(AppLocale? locale);
}
