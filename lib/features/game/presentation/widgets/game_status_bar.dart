import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

class GameStatusBar extends StatelessWidget {
  const GameStatusBar({
    super.key,
    required this.currentPlayer,
    required this.isAiThinking,
    required this.mode,
  });

  final Player currentPlayer;
  final bool isAiThinking;
  final GameMode mode;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;
    final color = currentPlayer == Player.x
        ? betclic.playerXColor
        : betclic.playerOColor;

    final String statusText;
    if (isAiThinking) {
      statusText = context.l10n.opponentTurn;
    } else if (mode is GameModeVsAi) {
      statusText = currentPlayer == Player.x
          ? context.l10n.yourTurn
          : context.l10n.opponentTurn;
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
      child: Row(
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
              child: CircularProgressIndicator(strokeWidth: 2, color: color),
            ),
          ],
        ],
      ),
    );
  }
}
