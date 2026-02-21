import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';

class CoinBalance extends StatelessWidget {
  const CoinBalance({super.key, required this.balance});

  final int balance;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monetization_on,
              color: betclic.coinColor,
              size: AppDimensions.iconL,
            ),
            const SizedBox(width: AppDimensions.spacingS),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.balance,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  context.l10n.coins(balance),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: betclic.coinColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
