// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchmaking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$matchmakingRepositoryHash() =>
    r'8c5cc4e7806bb06de5f464b896a31aba128e6f53';

/// See also [matchmakingRepository].
@ProviderFor(matchmakingRepository)
final matchmakingRepositoryProvider = Provider<MatchmakingRepository>.internal(
  matchmakingRepository,
  name: r'matchmakingRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$matchmakingRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MatchmakingRepositoryRef = ProviderRef<MatchmakingRepository>;
String _$mockMatchmakingRepositoryHash() =>
    r'55c98b880e020d20e6fd7dc08e5f82b903259c77';

/// See also [mockMatchmakingRepository].
@ProviderFor(mockMatchmakingRepository)
final mockMatchmakingRepositoryProvider =
    Provider<MockMatchmakingRepository>.internal(
      mockMatchmakingRepository,
      name: r'mockMatchmakingRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$mockMatchmakingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MockMatchmakingRepositoryRef = ProviderRef<MockMatchmakingRepository>;
String _$lobbyProposalsHash() => r'ad0faa0b761cdb87ff1892d08e0a028134b7b45c';

/// See also [lobbyProposals].
@ProviderFor(lobbyProposals)
final lobbyProposalsProvider = StreamProvider<List<MatchProposal>>.internal(
  lobbyProposals,
  name: r'lobbyProposalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lobbyProposalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LobbyProposalsRef = StreamProviderRef<List<MatchProposal>>;
String _$currentMockSessionHash() =>
    r'51d947a0846c244d61ac827ccc937d86175e5ead';

/// See also [CurrentMockSession].
@ProviderFor(CurrentMockSession)
final currentMockSessionProvider =
    NotifierProvider<CurrentMockSession, GameSession?>.internal(
      CurrentMockSession.new,
      name: r'currentMockSessionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentMockSessionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentMockSession = Notifier<GameSession?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
