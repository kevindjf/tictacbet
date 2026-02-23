import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_locale.dart';
import 'package:tic_tac_bet/features/settings/domain/entities/app_theme_mode.dart';

class _MockBox extends Mock implements Box<dynamic> {}

void main() {
  late _MockBox box;
  late SettingsRepositoryImpl repository;

  setUp(() {
    box = _MockBox();
    repository = SettingsRepositoryImpl(box);
  });

  group('SettingsRepositoryImpl', () {
    test('reads theme mode with fallback to default', () {
      when(() => box.get(any())).thenReturn('system');
      expect(repository.readThemeMode(), AppThemeMode.system);

      when(() => box.get(any())).thenReturn('unknown');
      expect(
        repository.readThemeMode(),
        SettingsRepositoryImpl.defaultThemeMode,
      );
    });

    test('writes theme mode as string', () async {
      when(() => box.put(any(), any())).thenAnswer((_) async {});

      await repository.writeThemeMode(AppThemeMode.light);

      verify(() => box.put('themeMode', 'light')).called(1);
    });

    test('reads difficulty with fallback to default', () {
      when(() => box.get(any())).thenReturn(Difficulty.hard.index);
      expect(repository.readDifficulty(), Difficulty.hard);

      when(() => box.get(any())).thenReturn(999);
      expect(
        repository.readDifficulty(),
        SettingsRepositoryImpl.defaultDifficulty,
      );
    });

    test('writes difficulty index', () async {
      when(() => box.put(any(), any())).thenAnswer((_) async {});

      await repository.writeDifficulty(Difficulty.easy);

      verify(() => box.put('difficulty', Difficulty.easy.index)).called(1);
    });

    test('reads locale and falls back to null for unsupported values', () {
      when(() => box.get(any())).thenReturn('fr');
      expect(repository.readLocale(), AppLocale.fr);

      when(() => box.get(any())).thenReturn('es');
      expect(repository.readLocale(), isNull);
    });

    test('writes locale name and clears locale when null', () async {
      when(() => box.put(any(), any())).thenAnswer((_) async {});
      when(() => box.delete(any())).thenAnswer((_) async {});

      await repository.writeLocale(AppLocale.en);
      await repository.writeLocale(null);

      verify(() => box.put('locale', 'en')).called(1);
      verify(() => box.delete('locale')).called(1);
    });
  });
}
