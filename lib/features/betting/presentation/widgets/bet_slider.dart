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
    this.multiplier = 1.0,
    required this.onChanged,
  });

  final int currentBet;
  final int maxBet;
  final int minimumBet;
  final double multiplier;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final betclic = context.betclic;
    final betRange = (maxBet - minimumBet).clamp(0, 1000000);
    final canBet = maxBet >= minimumBet;
    final effectiveBet = canBet
        ? currentBet.clamp(minimumBet, maxBet)
        : minimumBet;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.l10n.betAmount(effectiveBet),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Slider(
              value: effectiveBet.toDouble(),
              min: minimumBet.toDouble(),
              max: canBet ? maxBet.toDouble() : minimumBet.toDouble() + 1,
              divisions: canBet
                  ? (betRange <= 20
                        ? betRange.clamp(1, 20)
                        : (betRange ~/ 10).clamp(1, 100))
                  : 1,
              onChanged: canBet ? (value) => onChanged(value.round()) : null,
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Text(
              context.l10n.coinsWon((effectiveBet * 2 * multiplier).round()),
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
