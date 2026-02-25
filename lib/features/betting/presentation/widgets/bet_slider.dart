import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';

class BetSlider extends StatelessWidget {
  const BetSlider({
    super.key,
    required this.currentBet,
    required this.maxBet,
    required this.minimumBet,
    required this.potentialWinnings,
    this.enabled = true,
    required this.onChanged,
  });

  final int currentBet;
  final int maxBet;
  final int minimumBet;
  final int potentialWinnings;
  final bool enabled;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final betclic = context.betclic;
    final betRange = (maxBet - minimumBet).clamp(0, 1000000);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.l10n.betAmount(currentBet),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Slider(
              value: currentBet.toDouble(),
              min: minimumBet.toDouble(),
              max: enabled ? maxBet.toDouble() : minimumBet.toDouble() + 1,
              divisions: enabled
                  ? (betRange <= 20
                        ? betRange.clamp(1, 20)
                        : (betRange ~/ 10).clamp(1, 100))
                  : 1,
              onChanged: enabled ? (value) => onChanged(value.round()) : null,
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Text(
              context.l10n.coinsWon(potentialWinnings),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: betclic.coinColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
