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
String _$betPlacementViewModelHash() =>
    r'434a2b65f30e0b75ec68152a22c13ee462aa0903';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [betPlacementViewModel].
@ProviderFor(betPlacementViewModel)
const betPlacementViewModelProvider = BetPlacementViewModelFamily();

/// See also [betPlacementViewModel].
class BetPlacementViewModelFamily extends Family<BetPlacementViewModel> {
  /// See also [betPlacementViewModel].
  const BetPlacementViewModelFamily();

  /// See also [betPlacementViewModel].
  BetPlacementViewModelProvider call(bool forMatchmaking) {
    return BetPlacementViewModelProvider(forMatchmaking);
  }

  @override
  BetPlacementViewModelProvider getProviderOverride(
    covariant BetPlacementViewModelProvider provider,
  ) {
    return call(provider.forMatchmaking);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'betPlacementViewModelProvider';
}

/// See also [betPlacementViewModel].
class BetPlacementViewModelProvider
    extends AutoDisposeProvider<BetPlacementViewModel> {
  /// See also [betPlacementViewModel].
  BetPlacementViewModelProvider(bool forMatchmaking)
    : this._internal(
        (ref) => betPlacementViewModel(
          ref as BetPlacementViewModelRef,
          forMatchmaking,
        ),
        from: betPlacementViewModelProvider,
        name: r'betPlacementViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$betPlacementViewModelHash,
        dependencies: BetPlacementViewModelFamily._dependencies,
        allTransitiveDependencies:
            BetPlacementViewModelFamily._allTransitiveDependencies,
        forMatchmaking: forMatchmaking,
      );

  BetPlacementViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.forMatchmaking,
  }) : super.internal();

  final bool forMatchmaking;

  @override
  Override overrideWith(
    BetPlacementViewModel Function(BetPlacementViewModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BetPlacementViewModelProvider._internal(
        (ref) => create(ref as BetPlacementViewModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        forMatchmaking: forMatchmaking,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<BetPlacementViewModel> createElement() {
    return _BetPlacementViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BetPlacementViewModelProvider &&
        other.forMatchmaking == forMatchmaking;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, forMatchmaking.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BetPlacementViewModelRef
    on AutoDisposeProviderRef<BetPlacementViewModel> {
  /// The parameter `forMatchmaking` of this provider.
  bool get forMatchmaking;
}

class _BetPlacementViewModelProviderElement
    extends AutoDisposeProviderElement<BetPlacementViewModel>
    with BetPlacementViewModelRef {
  _BetPlacementViewModelProviderElement(super.provider);

  @override
  bool get forMatchmaking =>
      (origin as BetPlacementViewModelProvider).forMatchmaking;
}

String _$walletControllerHash() => r'0c76b363dcfe0c2b2dc41342909cbaac06d822bd';

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
