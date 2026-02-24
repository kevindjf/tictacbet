import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_coin_result_section.dart';

class GameResultOverlay extends StatelessWidget {
  const GameResultOverlay({
    super.key,
    required this.result,
    required this.mode,
    required this.onPlayAgain,
    required this.onBackToHome,
    this.coinsDelta,
    this.isResolvingBet = false,
  });

  final GameResult result;
  final GameMode mode;
  final VoidCallback onPlayAgain;
  final VoidCallback onBackToHome;

  /// Net coin change for the player in online mode. `null` means no bet was
  /// involved or the result is a draw (no display).
  final int? coinsDelta;

  /// Whether the bet resolution is still in progress.
  final bool isResolvingBet;

  @override
  Widget build(BuildContext context) {
    final betclic = context.betclic;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    final (title, color, icon) = switch (result) {
      GameResultWin(:final winner)
          when (mode is GameModeVsAi || mode is GameModeOnline) &&
              winner == Player.x =>
        (context.l10n.youWin, betclic.playerXColor, Icons.emoji_events),
      GameResultWin(:final winner)
          when (mode is GameModeVsAi || mode is GameModeOnline) &&
              winner == Player.o =>
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

    final showCoinSection =
        mode is GameModeOnline && (isResolvingBet || coinsDelta != null);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.45],
          colors: [Colors.transparent, scaffoldBg.withAlpha(245)],
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.spacingXL,
            0,
            AppDimensions.spacingXL,
            AppDimensions.spacingXL,
          ),
          child: SizedBox(
            width: double.infinity,
            child:
                Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.spacingXL),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 56, color: color).animate().scale(
                              begin: const Offset(0, 0),
                              duration: 400.ms,
                              curve: Curves.elasticOut,
                            ),
                            const SizedBox(height: AppDimensions.spacingM),
                            Text(
                              title,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(color: color),
                            ),
                            if (showCoinSection) ...[
                              const SizedBox(height: AppDimensions.spacingM),
                              GameCoinResultSection(
                                coinsDelta: coinsDelta ?? 0,
                                isLoading: isResolvingBet,
                              ),
                            ],
                            const SizedBox(height: AppDimensions.spacingXL),
                            if (mode is! GameModeOnline) ...[
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: onPlayAgain,
                                  child: Text(context.l10n.playAgain),
                                ),
                              ),
                              const SizedBox(height: AppDimensions.spacingS),
                            ],
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: onBackToHome,
                                child: Text(context.l10n.backToHome),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate()
                    .slideY(begin: 0.4, duration: 350.ms, curve: Curves.easeOut)
                    .fadeIn(duration: 250.ms),
          ),
        ),
      ),
    );
  }
}
