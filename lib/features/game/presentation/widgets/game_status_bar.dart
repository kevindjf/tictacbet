import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

class GameStatusBar extends ConsumerWidget {
  const GameStatusBar({
    super.key,
    required this.currentPlayer,
    required this.isAiThinking,
    required this.mode,
    this.onlineOpponentName,
  });

  final Player currentPlayer;
  final bool isAiThinking;
  final GameMode mode;
  final String? onlineOpponentName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final betclic = context.betclic;
    final currentBet = ref.watch(currentBetProvider);
    final color = currentPlayer == Player.x
        ? betclic.playerXColor
        : betclic.playerOColor;

    final String statusText;
    if (isAiThinking) {
      statusText = context.l10n.opponentTurn;
    } else if (mode is GameModeVsAi || mode is GameModeOnline) {
      statusText = currentPlayer == Player.x
          ? context.l10n.yourTurn
          : (mode is GameModeOnline && onlineOpponentName != null
                ? context.l10n.opponentTurnNamed(onlineOpponentName!)
                : context.l10n.opponentTurn);
    } else {
      statusText = currentPlayer == Player.x
          ? context.l10n.playerXTurn
          : context.l10n.playerOTurn;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingM,
        vertical: AppDimensions.spacingS,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppDimensions.iconS,
                height: AppDimensions.iconS,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppDimensions.spacingS),
              Text(
                statusText,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: color),
              ),
              if (isAiThinking) ...[
                const SizedBox(width: AppDimensions.spacingS),
                SizedBox(
                  width: AppDimensions.iconS,
                  height: AppDimensions.iconS,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                ),
              ],
            ],
          ),
          if (mode is GameModeOnline && currentBet != null) ...[
            const SizedBox(height: AppDimensions.spacingXS),
            Text(
              context.l10n.betAmount(currentBet.amount),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
