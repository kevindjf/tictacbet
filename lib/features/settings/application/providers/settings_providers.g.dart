// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsBoxHash() => r'd977cdf5ad5ab66c8a074c184a4380ec22048c01';

/// Provides the Hive box used for settings persistence.
///
/// Copied from [settingsBox].
@ProviderFor(settingsBox)
final settingsBoxProvider = Provider<Box<dynamic>>.internal(
  settingsBox,
  name: r'settingsBoxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsBoxRef = ProviderRef<Box<dynamic>>;
String _$settingsRepositoryHash() =>
    r'037493f058802a4d0ae2bae14a1a95efb47f9554';

/// Provides the settings repository abstraction backed by Hive.
///
/// Copied from [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider = Provider<SettingsRepository>.internal(
  settingsRepository,
  name: r'settingsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsRepositoryRef = ProviderRef<SettingsRepository>;
String _$themeModeControllerHash() =>
    r'5799749886f60d3d08e877a6468f9061ef5587db';

/// Controls the persisted theme mode setting.
///
/// Copied from [ThemeModeController].
@ProviderFor(ThemeModeController)
final themeModeControllerProvider =
    NotifierProvider<ThemeModeController, ThemeMode>.internal(
      ThemeModeController.new,
      name: r'themeModeControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeModeControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeModeController = Notifier<ThemeMode>;
String _$difficultyControllerHash() =>
    r'bfcde76a1eb75ef8fcd682547f183d0a59650cc7';

/// Controls the persisted AI difficulty setting.
///
/// Copied from [DifficultyController].
@ProviderFor(DifficultyController)
final difficultyControllerProvider =
    NotifierProvider<DifficultyController, Difficulty>.internal(
      DifficultyController.new,
      name: r'difficultyControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$difficultyControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DifficultyController = Notifier<Difficulty>;
String _$localeControllerHash() => r'6e9654457ea839c830121bd0a85b77f1183d9d5d';

/// Controls the persisted locale override setting.
///
/// Copied from [LocaleController].
@ProviderFor(LocaleController)
final localeControllerProvider =
    NotifierProvider<LocaleController, Locale?>.internal(
      LocaleController.new,
      name: r'localeControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$localeControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LocaleController = Notifier<Locale?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
