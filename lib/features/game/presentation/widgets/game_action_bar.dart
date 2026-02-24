import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';

class GameActionBar extends StatelessWidget {
  const GameActionBar({
    super.key,
    required this.mode,
    required this.onRestart,
    required this.onQuit,
  });

  final GameMode mode;
  final VoidCallback onRestart;
  final VoidCallback onQuit;

  @override
  Widget build(BuildContext context) {
    final isRanked = mode is GameModeOnline;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton.icon(
          onPressed: onQuit,
          icon: Icon(isRanked ? Icons.flag_outlined : Icons.exit_to_app),
          label: Text(isRanked ? context.l10n.abandon : context.l10n.quit),
        ),
        if (!isRanked) ...[
          const SizedBox(width: AppDimensions.spacingM),
          ElevatedButton.icon(
            onPressed: onRestart,
            icon: const Icon(Icons.refresh),
            label: Text(context.l10n.restart),
          ),
        ],
      ],
    );
  }
}
