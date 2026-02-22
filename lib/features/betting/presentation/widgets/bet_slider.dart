import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';

class BetSlider extends StatelessWidget {
  const BetSlider({
    super.key,
    required this.currentBet,
    required this.maxBet,
    required this.multiplier,
    required this.onChanged,
  });

  final int currentBet;
  final int maxBet;
  final double multiplier;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;
    final canBet = maxBet >= Wallet.minimumBet;
    final effectiveBet = canBet
        ? currentBet.clamp(Wallet.minimumBet, maxBet)
        : Wallet.minimumBet;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.betAmount(effectiveBet),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  context.l10n.multiplier(multiplier.toStringAsFixed(1)),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: betclic.streakColor),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Slider(
              value: effectiveBet.toDouble(),
              min: Wallet.minimumBet.toDouble(),
              max: canBet
                  ? maxBet.toDouble()
                  : Wallet.minimumBet.toDouble() + 1,
              divisions: canBet
                  ? ((maxBet - Wallet.minimumBet) ~/ 10).clamp(1, 100)
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
