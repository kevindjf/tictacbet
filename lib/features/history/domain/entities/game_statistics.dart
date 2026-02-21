import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_statistics.freezed.dart';

@freezed
sealed class GameStatistics with _$GameStatistics {
  const factory GameStatistics({
    @Default(0) int totalGames,
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int draws,
    @Default(0) int totalCoinsWon,
    @Default(0) int totalCoinsLost,
    @Default(0) int bestStreak,
  }) = _GameStatistics;

  const GameStatistics._();

  double get winRate => totalGames == 0 ? 0 : wins / totalGames;
}
