import 'dart:async';

import 'package:tic_tac_bet/features/matchmaking/domain/entities/game_session.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/entities/match_proposal.dart';
import 'package:tic_tac_bet/features/matchmaking/domain/repositories/matchmaking_repository.dart';

class MockMatchmakingRepository implements MatchmakingRepository {
  MockMatchmakingRepository._() {
    _seedIfNeeded();
    _emit();
  }

  static final MockMatchmakingRepository instance = MockMatchmakingRepository._();

  final _controller = StreamController<List<MatchProposal>>.broadcast(
    onListen: () {
      instance._emit();
    },
  );
  final List<MatchProposal> _proposals = [];
  bool _seeded = false;
  int _sequence = 0;

  static const localUserId = 'local-user';
  static const localUserName = 'You';

  @override
  Stream<List<MatchProposal>> watchProposals() async* {
    _emit();
    yield* _controller.stream;
  }

  @override
  Future<MatchProposal> createProposal(int betAmount) async {
    final now = DateTime.now();
    final proposal = MatchProposal(
      id: _nextId('proposal'),
      creatorId: localUserId,
      creatorName: localUserName,
      betAmount: betAmount,
      status: MatchStatus.waiting,
      createdAt: now,
      expiresAt: now.add(const Duration(minutes: 5)),
    );
    _proposals.insert(0, proposal);
    _emit();
    return proposal;
  }

  @override
  Future<GameSession> acceptProposal(String proposalId) async {
    final index = _proposals.indexWhere((p) => p.id == proposalId);
    if (index == -1) {
      throw StateError('Proposal not found');
    }

    final proposal = _proposals[index];
    if (!proposal.isWaiting) {
      throw StateError('Proposal is no longer available');
    }

    _proposals[index] = proposal.copyWith(
      status: MatchStatus.accepted,
      opponentId: localUserId,
    );
    _emit();

    return GameSession(
      id: _nextId('session'),
      proposalId: proposalId,
      playerXId: proposal.creatorId,
      playerOId: localUserId,
      status: SessionStatus.playing,
      createdAt: DateTime.now(),
    );
  }

  Future<GameSession> simulateOpponentAccept(String proposalId) async {
    final index = _proposals.indexWhere((p) => p.id == proposalId);
    if (index == -1) throw StateError('Proposal not found');

    final proposal = _proposals[index];
    if (!proposal.isWaiting || proposal.creatorId != localUserId) {
      throw StateError('Proposal cannot be matched');
    }

    _proposals[index] = proposal.copyWith(
      status: MatchStatus.accepted,
      opponentId: 'mock-opponent',
    );
    _emit();

    return GameSession(
      id: _nextId('session'),
      proposalId: proposalId,
      playerXId: localUserId,
      playerOId: 'mock-opponent',
      status: SessionStatus.playing,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> cancelProposal(String proposalId) async {
    final index = _proposals.indexWhere((p) => p.id == proposalId);
    if (index == -1) return;
    _proposals[index] = _proposals[index].copyWith(status: MatchStatus.cancelled);
    _emit();
  }

  void _seedIfNeeded() {
    if (_seeded) return;
    _seeded = true;
    final now = DateTime.now();
    _proposals.addAll([
      MatchProposal(
        id: _nextId('proposal'),
        creatorId: 'u_1',
        creatorName: 'Alex',
        betAmount: 50,
        status: MatchStatus.waiting,
        createdAt: now.subtract(const Duration(minutes: 1)),
        expiresAt: now.add(const Duration(minutes: 4)),
      ),
      MatchProposal(
        id: _nextId('proposal'),
        creatorId: 'u_2',
        creatorName: 'Sam',
        betAmount: 100,
        status: MatchStatus.waiting,
        createdAt: now.subtract(const Duration(minutes: 2)),
        expiresAt: now.add(const Duration(minutes: 3)),
      ),
      MatchProposal(
        id: _nextId('proposal'),
        creatorId: 'u_3',
        creatorName: 'Nina',
        betAmount: 250,
        status: MatchStatus.waiting,
        createdAt: now.subtract(const Duration(seconds: 30)),
        expiresAt: now.add(const Duration(minutes: 5)),
      ),
    ]);
  }

  void _emit() {
    final now = DateTime.now();
    final normalized = [
      for (final p in _proposals)
        if (p.status == MatchStatus.waiting && now.isAfter(p.expiresAt))
          p.copyWith(status: MatchStatus.expired)
        else
          p,
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    _proposals
      ..clear()
      ..addAll(normalized);
    _controller.add(List.unmodifiable(_proposals));
  }

  String _nextId(String prefix) => '$prefix-${_sequence++}';
}
