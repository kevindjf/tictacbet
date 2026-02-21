import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_proposal.freezed.dart';

@freezed
sealed class MatchProposal with _$MatchProposal {
  const factory MatchProposal({
    required String id,
    required String creatorId,
    required String creatorName,
    required int betAmount,
    required MatchStatus status,
    String? opponentId,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _MatchProposal;

  const MatchProposal._();

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isWaiting => status == MatchStatus.waiting && !isExpired;
}

enum MatchStatus { waiting, accepted, cancelled, expired }
