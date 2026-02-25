import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/router/app_router.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';
import 'package:tic_tac_bet/core/theme/app_typography_theme_extension.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/home_top_bar_icon_button.dart';

class HomeTopBar extends ConsumerWidget {
  const HomeTopBar({super.key, this.accentColor});

  final Color? accentColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletControllerProvider);
    final theme = Theme.of(context);
    final betclic = context.betclic;
    final tint = accentColor ?? AppColors.neonBlue;
    final logoStyle = theme.extension<AppTypographyTheme>()!.homeLogoStyle;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingM,
          vertical: AppDimensions.spacingS,
        ),
        child: Row(
          children: [
            Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.skewX(-0.08),
              child: RichText(
                text: TextSpan(
                  style: logoStyle.copyWith(
                    color: AppColors.darkTextPrimary,
                    shadows: [
                      Shadow(
                        color: AppColors.neonBlue.withAlpha(120),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  children: [
                    const TextSpan(text: 'TIC.TAC '),
                    TextSpan(
                      text: 'BET',
                      style: TextStyle(
                        color: AppColors.betclicRed,
                        shadows: [
                          Shadow(
                            color: AppColors.betclicRed.withAlpha(120),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingM,
                vertical: AppDimensions.spacingS,
              ),
              decoration: BoxDecoration(
                color: tint.withAlpha(40),
                borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                border: Border.all(color: tint.withAlpha(70)),
              ),
              child: Text(
                '${wallet.balance}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: betclic.coinColor,
                  shadows: [
                    Shadow(
                      color: theme.colorScheme.shadow.withAlpha(120),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacingS),
            HomeTopBarIconButton(
              icon: Icons.history,
              accentColor: accentColor,
              onPressed: () => context.pushNamed(AppRouter.history),
            ),
            const SizedBox(width: AppDimensions.spacingXS),
            HomeTopBarIconButton(
              icon: Icons.settings,
              accentColor: accentColor,
              onPressed: () => context.pushNamed(AppRouter.settings),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}
