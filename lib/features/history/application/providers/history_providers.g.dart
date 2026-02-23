// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyDatasourceHash() => r'6ce6a77f40f66779a6754a729a57e6e519d7f76c';

/// See also [historyDatasource].
@ProviderFor(historyDatasource)
final historyDatasourceProvider = Provider<HistoryLocalDatasource>.internal(
  historyDatasource,
  name: r'historyDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$historyDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HistoryDatasourceRef = ProviderRef<HistoryLocalDatasource>;
String _$historyRepositoryHash() => r'b7d58b1fa5a774a8bcce79b755a138eb5fb9e2b1';

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
String _$historyHash() => r'913e3c10a9477fe17444b46b642351ff0fdcef58';

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
String _$statisticsHash() => r'05d5c286c6c4d8c44c29cd3249e172c5e093da8a';

/// See also [statistics].
@ProviderFor(statistics)
final statisticsProvider = AutoDisposeFutureProvider<GameStatistics>.internal(
  statistics,
  name: r'statisticsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statisticsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatisticsRef = AutoDisposeFutureProviderRef<GameStatistics>;
String _$onlineStatisticsHash() => r'e0783e4558e6b22b85607df02f3468f44f4b7531';

/// See also [onlineStatistics].
@ProviderFor(onlineStatistics)
final onlineStatisticsProvider =
    AutoDisposeFutureProvider<GameStatistics>.internal(
      onlineStatistics,
      name: r'onlineStatisticsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onlineStatisticsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnlineStatisticsRef = AutoDisposeFutureProviderRef<GameStatistics>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
