import 'package:tic_tac_bet/features/betting/domain/entities/streak.dart';

class CalculateMultiplierUseCase {
  double call(Streak streak) => streak.multiplier;
}
