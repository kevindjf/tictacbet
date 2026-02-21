import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';

class GameCell extends StatelessWidget {
  const GameCell({
    super.key,
    required this.player,
    required this.isWinningCell,
    required this.onTap,
  });

  final Player? player;
  final bool isWinningCell;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;

    return GestureDetector(
      onTap: player == null ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isWinningCell ? betclic.winOverlayColor : betclic.cellColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: betclic.boardBorderColor,
            width: AppDimensions.boardBorderWidth,
          ),
        ),
        child: Center(
          child: player != null
              ? Text(
                  player!.symbol,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: player == Player.x
                        ? betclic.playerXColor
                        : betclic.playerOColor,
                    fontWeight: FontWeight.w900,
                  ),
                ).animate().scale(
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                  duration: 200.ms,
                  curve: Curves.elasticOut,
                )
              : null,
        ),
      ),
    );
  }
}
