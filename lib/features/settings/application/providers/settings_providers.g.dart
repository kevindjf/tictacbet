// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeModeSettingHash() => r'd5bf6c05af8ffc45458e9b74fd8ec4ff04176a39';

/// See also [ThemeModeSetting].
@ProviderFor(ThemeModeSetting)
final themeModeSettingProvider =
    NotifierProvider<ThemeModeSetting, ThemeMode>.internal(
      ThemeModeSetting.new,
      name: r'themeModeSettingProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeModeSettingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeModeSetting = Notifier<ThemeMode>;
String _$difficultySettingHash() => r'5fb1c307e450a5f8d5c37e767d11bea8fa582f95';

/// See also [DifficultySetting].
@ProviderFor(DifficultySetting)
final difficultySettingProvider =
    NotifierProvider<DifficultySetting, Difficulty>.internal(
      DifficultySetting.new,
      name: r'difficultySettingProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$difficultySettingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DifficultySetting = Notifier<Difficulty>;
String _$localeSettingHash() => r'8606a788383e16200d570591c87ee61725bbfd70';

/// See also [LocaleSetting].
@ProviderFor(LocaleSetting)
final localeSettingProvider = NotifierProvider<LocaleSetting, Locale?>.internal(
  LocaleSetting.new,
  name: r'localeSettingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localeSettingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocaleSetting = Notifier<Locale?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
