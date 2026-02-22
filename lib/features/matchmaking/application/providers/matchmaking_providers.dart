import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/features/matchmaking/data/repositories/mock_matchmaking_repository.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/game_session.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/match_proposal.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/repositories/matchmaking_repository.dart';

part 'matchmaking_providers.g.dart';

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

@Riverpod(keepAlive: true)
class CurrentMockSession extends _$CurrentMockSession {
  @override
  GameSession? build() => null;

  void setSession(GameSession? session) => state = session;
  void clear() => state = null;
}
