import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session.freezed.dart';

@freezed
sealed class GameSession with _$GameSession {
  const factory GameSession({
    required String id,
    required String proposalId,
    required String playerXId,
    required String playerOId,
    required SessionStatus status,
    String? winnerId,
    required DateTime createdAt,
  }) = _GameSession;
}

enum SessionStatus { playing, finished }
