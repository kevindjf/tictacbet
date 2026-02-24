import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/utils/date_formatter.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.entry});

  final GameHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final betclic = context.betclic;
    final coinsSubtitle = switch (entry.outcome) {
      GameOutcome.win when entry.coinsWon != null => (
        context.l10n.coinsWon(entry.coinsWon!),
        betclic.coinColor,
      ),
      GameOutcome.loss when entry.betAmount != null => (
        context.l10n.coinsLost(entry.betAmount!),
        betclic.playerOColor,
      ),
      GameOutcome.draw when entry.betAmount != null => (
        context.l10n.coinsWon(entry.betAmount!),
        betclic.coinColor,
      ),
      _ => null,
    };

    final (icon, color, label) = switch (entry.outcome) {
      GameOutcome.win => (
        Icons.emoji_events,
        betclic.playerXColor,
        context.l10n.won,
      ),
      GameOutcome.loss => (
        Icons.close,
        betclic.playerOColor,
        context.l10n.lost,
      ),
      GameOutcome.draw => (
        Icons.handshake,
        Theme.of(context).colorScheme.onSurfaceVariant,
        context.l10n.draw,
      ),
    };

    final opponent = switch (entry.mode) {
      GameModeVsAi(:final difficulty) => context.l10n.aiOpponent(
        difficulty.name,
      ),
      GameModeVsLocal() => context.l10n.localOpponent,
      GameModeOnline() => context.l10n.onlineOpponent,
    };

    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text('$label ${context.l10n.versus} $opponent'),
        subtitle: coinsSubtitle != null
            ? Text(
                coinsSubtitle.$1,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: coinsSubtitle.$2),
              )
            : null,
        trailing: Text(
          formatLocalizedShortDate(context, entry.playedAt),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingM,
          vertical: AppDimensions.spacingXS,
        ),
      ),
    );
  }
}
