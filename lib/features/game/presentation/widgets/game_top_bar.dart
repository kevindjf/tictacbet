import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/extensions/game_mode_ui_extension.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';
import 'package:tic_tac_bet/core/theme/app_typography_theme_extension.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_top_bar_pill.dart';

/// Game screen header with logo and wallet balance.
class GameTopBar extends ConsumerWidget {
  const GameTopBar({super.key, required this.mode});

  final GameMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletControllerProvider);
    final theme = Theme.of(context);
    final betclic = context.betclic;
    final tint = mode.accentColor;
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
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Transform(
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
              ),
            ),
            const SizedBox(width: AppDimensions.spacingS),
            GameTopBarPill(
              label: '${wallet.balance}',
              tint: tint,
              textColor: betclic.coinColor,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}
