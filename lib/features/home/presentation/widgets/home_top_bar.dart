import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';

class HomeTopBar extends ConsumerWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletControllerProvider);
    final theme = Theme.of(context);
    final betclic = theme.extension<BetclicTheme>()!;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingM,
          vertical: AppDimensions.spacingS,
        ),
        child: Row(
          children: [
            Text(
              context.l10n.appTitle.toUpperCase(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.onSurface,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: AppColors.neonBlue.withAlpha(180),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingM,
                vertical: AppDimensions.spacingS,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withAlpha(20),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: theme.colorScheme.onSurface.withAlpha(50)),
              ),
              child: Text(
                '${wallet.balance}',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: betclic.coinColor,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacingS),
            IconButton(
              icon: Icon(
                Icons.history,
                color: theme.colorScheme.onSurface.withAlpha(180),
              ),
              onPressed: () => context.pushNamed('history'),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: theme.colorScheme.onSurface.withAlpha(180),
              ),
              onPressed: () => context.pushNamed('settings'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}
