import 'package:flutter_riverpod/flutter_riverpod.dart' show AsyncValue, Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/features/matchmaking/data/repositories/mock_matchmaking_repository.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/game_session.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/match_proposal.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/repositories/matchmaking_repository.dart';

part 'matchmaking_providers.g.dart';

class LobbyViewModel {
  const LobbyViewModel({
    required this.myWaitingProposal,
    required this.availableProposals,
  });

  final MatchProposal? myWaitingProposal;
  final List<MatchProposal> availableProposals;

  bool get hasWaitingProposal => myWaitingProposal != null;
}

@Riverpod(keepAlive: true)
MatchmakingRepository matchmakingRepository(Ref ref) {
  return MockMatchmakingRepository.instance;
}

@Riverpod(keepAlive: true)
MockMatchmakingRepository mockMatchmakingRepository(
  Ref ref,
) {
  return MockMatchmakingRepository.instance;
}

@Riverpod(keepAlive: true)
Stream<List<MatchProposal>> lobbyProposals(Ref ref) {
  return ref.read(matchmakingRepositoryProvider).watchProposals();
}

@riverpod
AsyncValue<LobbyViewModel> lobbyViewModel(Ref ref) {
  return ref.watch(lobbyProposalsProvider).whenData((proposals) {
    final myWaiting = proposals
        .where(
          (p) =>
              p.creatorId == MockMatchmakingRepository.localUserId &&
              p.isWaiting,
        )
        .firstOrNull;

    final available = proposals
        .where(
          (p) =>
              p.isWaiting &&
              p.creatorId != MockMatchmakingRepository.localUserId,
        )
        .toList();

    return LobbyViewModel(
      myWaitingProposal: myWaiting,
      availableProposals: available,
    );
  });
}

@Riverpod(keepAlive: true)
class CurrentMockSession extends _$CurrentMockSession {
  @override
  GameSession? build() => null;

  void setSession(GameSession? session) => state = session;
  void clear() => state = null;
}
