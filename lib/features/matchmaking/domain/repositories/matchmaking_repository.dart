import 'package:tic_tac_bet/features/matchmaking/domain/entities/game_session.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/match_proposal.dart';

abstract class MatchmakingRepository {
  Stream<List<MatchProposal>> watchProposals();
  Future<MatchProposal> createProposal(int betAmount);
  Future<GameSession> acceptProposal(String proposalId);
  Future<void> cancelProposal(String proposalId);
}
