import 'dart:ui';

import 'package:tic_tac_bet/core/theme/app_colors.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';

/// UI-specific helpers on [GameMode].
extension GameModeUi on GameMode {
  /// Neon accent color associated with this game mode.
  Color get accentColor => switch (this) {
    GameModeOnline() => AppColors.neonRed,
    GameModeVsAi() => AppColors.neonBlue,
    GameModeVsLocal() => AppColors.neonGold,
  };
}
