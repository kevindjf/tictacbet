// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyRepositoryHash() => r'12dd6a0984117a10276252a87353d8b6b8ec2eee';

/// See also [historyRepository].
@ProviderFor(historyRepository)
final historyRepositoryProvider = Provider<HistoryRepository>.internal(
  historyRepository,
  name: r'historyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$historyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HistoryRepositoryRef = ProviderRef<HistoryRepository>;
String _$getHistoryUseCaseHash() => r'252b74d8d3d1bfab5326a2c5e90800b02279245d';

/// See also [getHistoryUseCase].
@ProviderFor(getHistoryUseCase)
final getHistoryUseCaseProvider = Provider<GetHistoryUseCase>.internal(
  getHistoryUseCase,
  name: r'getHistoryUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getHistoryUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetHistoryUseCaseRef = ProviderRef<GetHistoryUseCase>;
String _$getStatisticsUseCaseHash() =>
    r'e76736e13800de1aaf560bfd01f6bc548f267a9f';

/// See also [getStatisticsUseCase].
@ProviderFor(getStatisticsUseCase)
final getStatisticsUseCaseProvider = Provider<GetStatisticsUseCase>.internal(
  getStatisticsUseCase,
  name: r'getStatisticsUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getStatisticsUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetStatisticsUseCaseRef = ProviderRef<GetStatisticsUseCase>;
String _$saveGameResultUseCaseHash() =>
    r'07dc1e593ed6c685168600d9928bf98a790ff47a';

/// See also [saveGameResultUseCase].
@ProviderFor(saveGameResultUseCase)
final saveGameResultUseCaseProvider = Provider<SaveGameResultUseCase>.internal(
  saveGameResultUseCase,
  name: r'saveGameResultUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveGameResultUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SaveGameResultUseCaseRef = ProviderRef<SaveGameResultUseCase>;
String _$historyHash() => r'c92b8a5616e73212ad162ca40258b9dd77201d95';

/// See also [history].
@ProviderFor(history)
final historyProvider =
    AutoDisposeFutureProvider<List<GameHistoryEntry>>.internal(
      history,
      name: r'historyProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$historyHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HistoryRef = AutoDisposeFutureProviderRef<List<GameHistoryEntry>>;
String _$statisticsHash() => r'5e7ccdce430388c0b1b82fbca339053d49a3c6da';

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

/// See also [statistics].
@ProviderFor(statistics)
const statisticsProvider = StatisticsFamily();

/// See also [statistics].
class StatisticsFamily extends Family<AsyncValue<GameStatistics>> {
  /// See also [statistics].
  const StatisticsFamily();

  /// See also [statistics].
  StatisticsProvider call({required bool onlineOnly}) {
    return StatisticsProvider(onlineOnly: onlineOnly);
  }

  @override
  StatisticsProvider getProviderOverride(
    covariant StatisticsProvider provider,
  ) {
    return call(onlineOnly: provider.onlineOnly);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'statisticsProvider';
}

/// See also [statistics].
class StatisticsProvider extends AutoDisposeFutureProvider<GameStatistics> {
  /// See also [statistics].
  StatisticsProvider({required bool onlineOnly})
    : this._internal(
        (ref) => statistics(ref as StatisticsRef, onlineOnly: onlineOnly),
        from: statisticsProvider,
        name: r'statisticsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$statisticsHash,
        dependencies: StatisticsFamily._dependencies,
        allTransitiveDependencies: StatisticsFamily._allTransitiveDependencies,
        onlineOnly: onlineOnly,
      );

  StatisticsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.onlineOnly,
  }) : super.internal();

  final bool onlineOnly;

  @override
  Override overrideWith(
    FutureOr<GameStatistics> Function(StatisticsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StatisticsProvider._internal(
        (ref) => create(ref as StatisticsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        onlineOnly: onlineOnly,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GameStatistics> createElement() {
    return _StatisticsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StatisticsProvider && other.onlineOnly == onlineOnly;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, onlineOnly.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StatisticsRef on AutoDisposeFutureProviderRef<GameStatistics> {
  /// The parameter `onlineOnly` of this provider.
  bool get onlineOnly;
}

class _StatisticsProviderElement
    extends AutoDisposeFutureProviderElement<GameStatistics>
    with StatisticsRef {
  _StatisticsProviderElement(super.provider);

  @override
  bool get onlineOnly => (origin as StatisticsProvider).onlineOnly;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
