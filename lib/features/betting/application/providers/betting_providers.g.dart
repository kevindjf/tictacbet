// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'betting_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$walletDatasourceHash() => r'cddee9461e3afcf72f0591fb966d1e6aa4d817dd';

/// See also [walletDatasource].
@ProviderFor(walletDatasource)
final walletDatasourceProvider = Provider<WalletLocalDatasource>.internal(
  walletDatasource,
  name: r'walletDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletDatasourceRef = ProviderRef<WalletLocalDatasource>;
String _$walletRepositoryHash() => r'a20bc97d5d91cb44f787a62a8a56f26405f57033';

/// See also [walletRepository].
@ProviderFor(walletRepository)
final walletRepositoryProvider = Provider<WalletRepository>.internal(
  walletRepository,
  name: r'walletRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletRepositoryRef = ProviderRef<WalletRepository>;
String _$placeBetUseCaseHash() => r'ef1f7bc16e8e81c7d16a88d7b7576f0e473e167b';

/// See also [placeBetUseCase].
@ProviderFor(placeBetUseCase)
final placeBetUseCaseProvider = Provider<PlaceBetUseCase>.internal(
  placeBetUseCase,
  name: r'placeBetUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$placeBetUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PlaceBetUseCaseRef = ProviderRef<PlaceBetUseCase>;
String _$resolveBetUseCaseHash() => r'2ff54703a73686ca2dccf696aa70755a8cbcd49d';

/// See also [resolveBetUseCase].
@ProviderFor(resolveBetUseCase)
final resolveBetUseCaseProvider = Provider<ResolveBetUseCase>.internal(
  resolveBetUseCase,
  name: r'resolveBetUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resolveBetUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResolveBetUseCaseRef = ProviderRef<ResolveBetUseCase>;
String _$bettingServiceHash() => r'c540b586ba080f3d047fa7cdad5a5c4a2afdb1fc';

/// See also [bettingService].
@ProviderFor(bettingService)
final bettingServiceProvider = Provider<BettingService>.internal(
  bettingService,
  name: r'bettingServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bettingServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BettingServiceRef = ProviderRef<BettingService>;
String _$walletControllerHash() => r'719b9129393d173359e62965c9483df88cb2c050';

/// See also [WalletController].
@ProviderFor(WalletController)
final walletControllerProvider =
    NotifierProvider<WalletController, Wallet>.internal(
      WalletController.new,
      name: r'walletControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$walletControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WalletController = Notifier<Wallet>;
String _$streakControllerHash() => r'69101b3592e389c1d63536ac610519754c149d19';

/// See also [StreakController].
@ProviderFor(StreakController)
final streakControllerProvider =
    NotifierProvider<StreakController, Streak>.internal(
      StreakController.new,
      name: r'streakControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$streakControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StreakController = Notifier<Streak>;
String _$currentBetHash() => r'e457773bd207c431d8292cf8f4ed56832d2ccdee';

/// See also [CurrentBet].
@ProviderFor(CurrentBet)
final currentBetProvider = NotifierProvider<CurrentBet, Bet?>.internal(
  CurrentBet.new,
  name: r'currentBetProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentBetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentBet = Notifier<Bet?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
