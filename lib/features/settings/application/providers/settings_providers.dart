import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider, Ref;
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_locale.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:tic_tac_bet/features/settings/domain/repositories/settings_repository.dart';

part 'settings_providers.g.dart';

/// Opens existing Hive boxes used by the settings feature.
class SettingsHiveBoxAccessor {
  /// Creates a Hive box accessor for settings persistence.
  const SettingsHiveBoxAccessor();

  /// Returns the already-opened settings Hive box.
  Box<dynamic> settingsBox() => Hive.box(SettingsRepositoryImpl.boxName);
}

/// Provides access to Hive boxes used by settings repositories.
final settingsHiveBoxAccessorProvider = Provider<SettingsHiveBoxAccessor>(
  (ref) => const SettingsHiveBoxAccessor(),
);

@Riverpod(keepAlive: true)
/// Provides the Hive box used for settings persistence.
Box<dynamic> settingsBox(Ref ref) {
  return ref.watch(settingsHiveBoxAccessorProvider).settingsBox();
}

@Riverpod(keepAlive: true)
/// Provides the settings repository abstraction backed by Hive.
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepositoryImpl(ref.watch(settingsBoxProvider));
}

@Riverpod(keepAlive: true)
/// Controls the persisted theme mode setting.
class ThemeModeController extends _$ThemeModeController {
  SettingsRepository get _repository => ref.read(settingsRepositoryProvider);

  @override
  ThemeMode build() => _repository.readThemeMode().toFlutter();

  /// Updates and persists the selected theme mode.
  Future<void> setValue(ThemeMode mode) async {
    state = mode;
    await _repository.writeThemeMode(mode.toDomain());
  }
}

@Riverpod(keepAlive: true)
/// Controls the persisted AI difficulty setting.
class DifficultyController extends _$DifficultyController {
  SettingsRepository get _repository => ref.read(settingsRepositoryProvider);

  @override
  Difficulty build() => _repository.readDifficulty();

  /// Updates and persists the selected difficulty.
  Future<void> setValue(Difficulty difficulty) async {
    state = difficulty;
    await _repository.writeDifficulty(difficulty);
  }
}

@Riverpod(keepAlive: true)
/// Controls the persisted locale override setting.
class LocaleController extends _$LocaleController {
  SettingsRepository get _repository => ref.read(settingsRepositoryProvider);

  static const Locale _fallbackLocale = Locale('en');

  @override
  Locale? build() => _repository.readLocale()?.toFlutter();

  /// Updates and persists the locale override.
  Future<void> setValue(Locale? locale) async {
    state = locale;
    await _repository.writeLocale(locale?.toDomain());
  }

  /// Resolves the locale used by the language selector from saved/system values.
  Locale resolvedLocale(Locale systemLocale) {
    final candidate = state ?? systemLocale;
    return switch (candidate.languageCode) {
      'fr' => const Locale('fr'),
      'en' => const Locale('en'),
      _ => _fallbackLocale,
    };
  }
}

/// Maps [AppThemeMode] domain values to Flutter [ThemeMode].
extension AppThemeModeMapper on AppThemeMode {
  /// Converts to the Flutter equivalent.
  ThemeMode toFlutter() => switch (this) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };
}

/// Maps Flutter [ThemeMode] to [AppThemeMode] domain values.
extension ThemeModeMapper on ThemeMode {
  /// Converts to the domain equivalent.
  AppThemeMode toDomain() => switch (this) {
    ThemeMode.system => AppThemeMode.system,
    ThemeMode.light => AppThemeMode.light,
    ThemeMode.dark => AppThemeMode.dark,
  };
}

/// Maps [AppLocale] domain values to Flutter [Locale].
extension AppLocaleMapper on AppLocale {
  /// Converts to the Flutter equivalent.
  Locale toFlutter() => Locale(name);
}

/// Maps Flutter [Locale] to [AppLocale] domain values.
extension LocaleMapper on Locale {
  /// Converts to the domain equivalent, or `null` for unsupported locales.
  AppLocale? toDomain() => switch (languageCode) {
    'en' => AppLocale.en,
    'fr' => AppLocale.fr,
    _ => null,
  };
}
