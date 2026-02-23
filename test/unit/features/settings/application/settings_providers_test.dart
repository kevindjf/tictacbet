import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/settings/application/providers/settings_providers.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_locale.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:tic_tac_bet/features/settings/domain/repositories/settings_repository.dart';

class _FakeSettingsRepository implements SettingsRepository {
  _FakeSettingsRepository({
    this.themeMode = AppThemeMode.dark,
    this.difficulty = Difficulty.medium,
    this.locale,
  });

  AppThemeMode themeMode;
  Difficulty difficulty;
  AppLocale? locale;

  @override
  AppThemeMode readThemeMode() => themeMode;

  @override
  Future<void> writeThemeMode(AppThemeMode mode) async {
    themeMode = mode;
  }

  @override
  Difficulty readDifficulty() => difficulty;

  @override
  Future<void> writeDifficulty(Difficulty value) async {
    difficulty = value;
  }

  @override
  AppLocale? readLocale() => locale;

  @override
  Future<void> writeLocale(AppLocale? value) async {
    locale = value;
  }
}

void main() {
  group('settings providers', () {
    test(
      'ThemeModeController reads initial state and persists updates',
      () async {
        final fakeRepository = _FakeSettingsRepository(
          themeMode: AppThemeMode.system,
        );
        final container = ProviderContainer(
          overrides: [
            settingsRepositoryProvider.overrideWith((ref) => fakeRepository),
          ],
        );
        addTearDown(container.dispose);

        expect(container.read(themeModeControllerProvider), ThemeMode.system);

        await container
            .read(themeModeControllerProvider.notifier)
            .setValue(ThemeMode.light);

        expect(container.read(themeModeControllerProvider), ThemeMode.light);
        expect(fakeRepository.themeMode, AppThemeMode.light);
      },
    );

    test(
      'DifficultyController reads initial state and persists updates',
      () async {
        final fakeRepository = _FakeSettingsRepository(
          difficulty: Difficulty.easy,
        );
        final container = ProviderContainer(
          overrides: [
            settingsRepositoryProvider.overrideWith((ref) => fakeRepository),
          ],
        );
        addTearDown(container.dispose);

        expect(container.read(difficultyControllerProvider), Difficulty.easy);

        await container
            .read(difficultyControllerProvider.notifier)
            .setValue(Difficulty.hard);

        expect(container.read(difficultyControllerProvider), Difficulty.hard);
        expect(fakeRepository.difficulty, Difficulty.hard);
      },
    );

    test(
      'LocaleController reads, persists and resolves locale fallback',
      () async {
        final fakeRepository = _FakeSettingsRepository(locale: null);
        final container = ProviderContainer(
          overrides: [
            settingsRepositoryProvider.overrideWith((ref) => fakeRepository),
          ],
        );
        addTearDown(container.dispose);

        final controller = container.read(localeControllerProvider.notifier);

        expect(container.read(localeControllerProvider), isNull);
        expect(
          controller.resolvedLocale(const Locale('fr')),
          const Locale('fr'),
        );
        expect(
          controller.resolvedLocale(const Locale('es')),
          const Locale('en'),
        );

        await controller.setValue(const Locale('en'));

        expect(container.read(localeControllerProvider), const Locale('en'));
        expect(fakeRepository.locale, AppLocale.en);
        expect(
          controller.resolvedLocale(const Locale('fr')),
          const Locale('en'),
        );
      },
    );
  });
}
