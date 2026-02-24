import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';

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

  factory GameStatistics.fromEntries(Iterable<GameHistoryEntry> entries) {
    final entryList = entries.toList();
    if (entryList.isEmpty) return const GameStatistics();

    var wins = 0;
    var losses = 0;
    var draws = 0;
    var totalCoinsWon = 0;
    var totalCoinsLost = 0;
    var bestStreak = 0;
    var currentStreak = 0;

    for (final entry in entryList.reversed) {
      switch (entry.outcome) {
        case GameOutcome.win:
          wins++;
          currentStreak++;
          if (currentStreak > bestStreak) bestStreak = currentStreak;
          if (entry.coinsWon != null) totalCoinsWon += entry.coinsWon!;
        case GameOutcome.loss:
          losses++;
          currentStreak = 0;
          if (entry.betAmount != null) totalCoinsLost += entry.betAmount!;
        case GameOutcome.draw:
          draws++;
          currentStreak = 0;
      }
    }

    return GameStatistics(
      totalGames: entryList.length,
      wins: wins,
      losses: losses,
      draws: draws,
      totalCoinsWon: totalCoinsWon,
      totalCoinsLost: totalCoinsLost,
      bestStreak: bestStreak,
    );
  }

  const GameStatistics._();

  double get winRate => totalGames == 0 ? 0 : wins / totalGames;
}
