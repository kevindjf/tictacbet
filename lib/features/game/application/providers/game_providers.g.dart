// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$checkWinnerUseCaseHash() =>
    r'073fa593835ffd21a4da4d8d98da0815449f50d2';

/// See also [checkWinnerUseCase].
@ProviderFor(checkWinnerUseCase)
final checkWinnerUseCaseProvider =
    AutoDisposeProvider<CheckWinnerUseCase>.internal(
      checkWinnerUseCase,
      name: r'checkWinnerUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$checkWinnerUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CheckWinnerUseCaseRef = AutoDisposeProviderRef<CheckWinnerUseCase>;
String _$makeMoveUseCaseHash() => r'bba0a7885251d0694279829753526230324b2c24';

/// See also [makeMoveUseCase].
@ProviderFor(makeMoveUseCase)
final makeMoveUseCaseProvider = AutoDisposeProvider<MakeMoveUseCase>.internal(
  makeMoveUseCase,
  name: r'makeMoveUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$makeMoveUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MakeMoveUseCaseRef = AutoDisposeProviderRef<MakeMoveUseCase>;
String _$aiMoveUseCaseHash() => r'0cb19f56f9c6eb5f180d9541c87989044db797f8';

/// See also [aiMoveUseCase].
@ProviderFor(aiMoveUseCase)
final aiMoveUseCaseProvider = AutoDisposeProvider<AiMoveUseCase>.internal(
  aiMoveUseCase,
  name: r'aiMoveUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiMoveUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiMoveUseCaseRef = AutoDisposeProviderRef<AiMoveUseCase>;
String _$gameControllerHash() => r'2d0766e9a5426d3e6263ef82c7b403bc51798390';

/// See also [GameController].
@ProviderFor(GameController)
final gameControllerProvider =
    AutoDisposeNotifierProvider<GameController, GameState>.internal(
      GameController.new,
      name: r'gameControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gameControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GameController = AutoDisposeNotifier<GameState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
