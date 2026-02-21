import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';

class GameActionBar extends StatelessWidget {
  const GameActionBar({
    super.key,
    required this.onRestart,
    required this.onQuit,
  });

  final VoidCallback onRestart;
  final VoidCallback onQuit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton.icon(
          onPressed: onQuit,
          icon: const Icon(Icons.exit_to_app),
          label: Text(context.l10n.quit),
        ),
        const SizedBox(width: AppDimensions.spacingM),
        ElevatedButton.icon(
          onPressed: onRestart,
          icon: const Icon(Icons.refresh),
          label: Text(context.l10n.restart),
        ),
      ],
    );
  }
}
