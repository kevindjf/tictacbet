import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

class GameResultOverlay extends StatelessWidget {
  const GameResultOverlay({
    super.key,
    required this.result,
    required this.mode,
    required this.onPlayAgain,
    required this.onBackToHome,
  });

  final GameResult result;
  final GameMode mode;
  final VoidCallback onPlayAgain;
  final VoidCallback onBackToHome;

  @override
  Widget build(BuildContext context) {
    final betclic = context.betclic;

    final (title, color, icon) = switch (result) {
      GameResultWin(:final winner)
          when mode is GameModeVsAi && winner == Player.x =>
        (context.l10n.youWin, betclic.playerXColor, Icons.emoji_events),
      GameResultWin(:final winner)
          when mode is GameModeVsAi && winner == Player.o =>
        (
          context.l10n.youLose,
          betclic.playerOColor,
          Icons.sentiment_dissatisfied,
        ),
      GameResultWin(:final winner) when winner == Player.x => (
        context.l10n.playerXWins,
        betclic.playerXColor,
        Icons.emoji_events,
      ),
      GameResultWin() => (
        context.l10n.playerOWins,
        betclic.playerOColor,
        Icons.emoji_events,
      ),
      GameResultDraw() => (
        context.l10n.draw,
        Theme.of(context).colorScheme.onSurfaceVariant,
        Icons.handshake,
      ),
      GameResultOngoing() => ('', Colors.transparent, Icons.error),
    };

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor.withAlpha(230),
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingXL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 64, color: color).animate().scale(
                  begin: const Offset(0, 0),
                  duration: 400.ms,
                  curve: Curves.elasticOut,
                ),
                const SizedBox(height: AppDimensions.spacingM),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: color),
                ),
                const SizedBox(height: AppDimensions.spacingXL),
                ElevatedButton(
                  onPressed: onPlayAgain,
                  child: Text(context.l10n.playAgain),
                ),
                const SizedBox(height: AppDimensions.spacingS),
                TextButton(
                  onPressed: onBackToHome,
                  child: Text(context.l10n.backToHome),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2),
      ),
    );
  }
}
