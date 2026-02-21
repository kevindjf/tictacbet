import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';

class BetclicTheme extends ThemeExtension<BetclicTheme> {
  const BetclicTheme({
    required this.playerXColor,
    required this.playerOColor,
    required this.coinColor,
    required this.coinColorDark,
    required this.streakColor,
    required this.boardBorderColor,
    required this.cellColor,
    required this.cellHighlightColor,
    required this.winOverlayColor,
    required this.lossOverlayColor,
  });

  final Color playerXColor;
  final Color playerOColor;
  final Color coinColor;
  final Color coinColorDark;
  final Color streakColor;
  final Color boardBorderColor;
  final Color cellColor;
  final Color cellHighlightColor;
  final Color winOverlayColor;
  final Color lossOverlayColor;

  static const dark = BetclicTheme(
    playerXColor: AppColors.playerX,
    playerOColor: AppColors.playerO,
    coinColor: AppColors.gold,
    coinColorDark: AppColors.goldDark,
    streakColor: AppColors.gold,
    boardBorderColor: AppColors.darkBorder,
    cellColor: AppColors.darkCard,
    cellHighlightColor: AppColors.darkSurface,
    winOverlayColor: Color(0x332EA043),
    lossOverlayColor: Color(0x33DA3633),
  );

  static const light = BetclicTheme(
    playerXColor: AppColors.playerX,
    playerOColor: AppColors.playerO,
    coinColor: AppColors.gold,
    coinColorDark: AppColors.goldDark,
    streakColor: AppColors.gold,
    boardBorderColor: AppColors.lightBorder,
    cellColor: AppColors.lightCard,
    cellHighlightColor: Color(0xFFF3F4F6),
    winOverlayColor: Color(0x332EA043),
    lossOverlayColor: Color(0x33DA3633),
  );

  @override
  BetclicTheme copyWith({
    Color? playerXColor,
    Color? playerOColor,
    Color? coinColor,
    Color? coinColorDark,
    Color? streakColor,
    Color? boardBorderColor,
    Color? cellColor,
    Color? cellHighlightColor,
    Color? winOverlayColor,
    Color? lossOverlayColor,
  }) {
    return BetclicTheme(
      playerXColor: playerXColor ?? this.playerXColor,
      playerOColor: playerOColor ?? this.playerOColor,
      coinColor: coinColor ?? this.coinColor,
      coinColorDark: coinColorDark ?? this.coinColorDark,
      streakColor: streakColor ?? this.streakColor,
      boardBorderColor: boardBorderColor ?? this.boardBorderColor,
      cellColor: cellColor ?? this.cellColor,
      cellHighlightColor: cellHighlightColor ?? this.cellHighlightColor,
      winOverlayColor: winOverlayColor ?? this.winOverlayColor,
      lossOverlayColor: lossOverlayColor ?? this.lossOverlayColor,
    );
  }

  @override
  BetclicTheme lerp(covariant BetclicTheme? other, double t) {
    if (other == null) return this;
    return BetclicTheme(
      playerXColor: Color.lerp(playerXColor, other.playerXColor, t)!,
      playerOColor: Color.lerp(playerOColor, other.playerOColor, t)!,
      coinColor: Color.lerp(coinColor, other.coinColor, t)!,
      coinColorDark: Color.lerp(coinColorDark, other.coinColorDark, t)!,
      streakColor: Color.lerp(streakColor, other.streakColor, t)!,
      boardBorderColor: Color.lerp(
        boardBorderColor,
        other.boardBorderColor,
        t,
      )!,
      cellColor: Color.lerp(cellColor, other.cellColor, t)!,
      cellHighlightColor: Color.lerp(
        cellHighlightColor,
        other.cellHighlightColor,
        t,
      )!,
      winOverlayColor: Color.lerp(winOverlayColor, other.winOverlayColor, t)!,
      lossOverlayColor: Color.lerp(
        lossOverlayColor,
        other.lossOverlayColor,
        t,
      )!,
    );
  }
}
