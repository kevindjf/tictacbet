import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';

class BetResolution {
  const BetResolution({
    required this.balanceChange,
    required this.newStreakCount,
  });

  final int balanceChange;
  final int newStreakCount;
}

class ResolveBetUseCase {
  BetResolution call(Bet bet, GameOutcome outcome, int currentStreakCount) {
    return switch (outcome) {
      GameOutcome.win => BetResolution(
        balanceChange: bet.potentialWinnings,
        newStreakCount: currentStreakCount + 1,
      ),
      GameOutcome.loss => BetResolution(balanceChange: 0, newStreakCount: 0),
      GameOutcome.draw => BetResolution(
        balanceChange: bet.amount,
        newStreakCount: 0,
      ),
    };
  }
}
