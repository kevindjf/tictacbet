import 'package:tic_tac_bet/core/entities/game_outcome.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet_resolution.dart';

class ResolveBetUseCase {
  BetResolution call(Bet bet, GameOutcome outcome) {
    return switch (outcome) {
      GameOutcome.win => BetResolution(balanceChange: bet.potentialWinnings),
      GameOutcome.loss => const BetResolution(balanceChange: 0),
      GameOutcome.draw => BetResolution(balanceChange: bet.amount),
    };
  }
}
