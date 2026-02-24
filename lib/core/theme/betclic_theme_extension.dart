import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';

class BetclicTheme extends ThemeExtension<BetclicTheme> {
  const BetclicTheme({
    required this.playerXColor,
    required this.playerOColor,
    required this.coinColor,
    required this.coinColorDark,
    required this.boardBorderColor,
    required this.cellColor,
    required this.cellHighlightColor,
    required this.winOverlayColor,
    required this.lossOverlayColor,
    required this.coachTextColor,
    required this.coachTextShadowColor,
    required this.coachCardBackgroundColor,
    required this.coachCardBorderColor,
    required this.coachCardShadowColor,
  });

  final Color playerXColor;
  final Color playerOColor;
  final Color coinColor;
  final Color coinColorDark;
  final Color boardBorderColor;
  final Color cellColor;
  final Color cellHighlightColor;
  final Color winOverlayColor;
  final Color lossOverlayColor;

  /// Foreground color for tutorial coach text overlays.
  final Color coachTextColor;

  /// Shadow color applied to tutorial coach text for readability.
  final Color coachTextShadowColor;

  /// Background color of the tutorial coach message card.
  final Color coachCardBackgroundColor;

  /// Border color of the tutorial coach message card.
  final Color coachCardBorderColor;

  /// Drop shadow color of the tutorial coach message card.
  final Color coachCardShadowColor;

  static const dark = BetclicTheme(
    playerXColor: AppColors.playerX,
    playerOColor: AppColors.playerO,
    coinColor: AppColors.gold,
    coinColorDark: AppColors.goldDark,
    boardBorderColor: AppColors.darkBorder,
    cellColor: AppColors.darkCard,
    cellHighlightColor: AppColors.darkSurface,
    winOverlayColor: Color(0x332EA043),
    lossOverlayColor: Color(0x33DA3633),
    coachTextColor: Colors.white,
    coachTextShadowColor: Color(0xCC000000),
    coachCardBackgroundColor: Color(0xCC111827),
    coachCardBorderColor: Color(0x47FFFFFF),
    coachCardShadowColor: Color(0xAA000000),
  );

  static const light = BetclicTheme(
    playerXColor: AppColors.playerX,
    playerOColor: AppColors.playerO,
    coinColor: AppColors.gold,
    coinColorDark: AppColors.goldDark,
    boardBorderColor: AppColors.lightBorder,
    cellColor: AppColors.lightCard,
    cellHighlightColor: Color(0xFFF3F4F6),
    winOverlayColor: Color(0x332EA043),
    lossOverlayColor: Color(0x33DA3633),
    coachTextColor: Colors.white,
    coachTextShadowColor: Color(0xCC000000),
    coachCardBackgroundColor: Color(0xCC111827),
    coachCardBorderColor: Color(0x47FFFFFF),
    coachCardShadowColor: Color(0xAA000000),
  );

  @override
  BetclicTheme copyWith({
    Color? playerXColor,
    Color? playerOColor,
    Color? coinColor,
    Color? coinColorDark,
    Color? boardBorderColor,
    Color? cellColor,
    Color? cellHighlightColor,
    Color? winOverlayColor,
    Color? lossOverlayColor,
    Color? coachTextColor,
    Color? coachTextShadowColor,
    Color? coachCardBackgroundColor,
    Color? coachCardBorderColor,
    Color? coachCardShadowColor,
  }) {
    return BetclicTheme(
      playerXColor: playerXColor ?? this.playerXColor,
      playerOColor: playerOColor ?? this.playerOColor,
      coinColor: coinColor ?? this.coinColor,
      coinColorDark: coinColorDark ?? this.coinColorDark,
      boardBorderColor: boardBorderColor ?? this.boardBorderColor,
      cellColor: cellColor ?? this.cellColor,
      cellHighlightColor: cellHighlightColor ?? this.cellHighlightColor,
      winOverlayColor: winOverlayColor ?? this.winOverlayColor,
      lossOverlayColor: lossOverlayColor ?? this.lossOverlayColor,
      coachTextColor: coachTextColor ?? this.coachTextColor,
      coachTextShadowColor: coachTextShadowColor ?? this.coachTextShadowColor,
      coachCardBackgroundColor:
          coachCardBackgroundColor ?? this.coachCardBackgroundColor,
      coachCardBorderColor: coachCardBorderColor ?? this.coachCardBorderColor,
      coachCardShadowColor: coachCardShadowColor ?? this.coachCardShadowColor,
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
      coachTextColor: Color.lerp(coachTextColor, other.coachTextColor, t)!,
      coachTextShadowColor: Color.lerp(
        coachTextShadowColor,
        other.coachTextShadowColor,
        t,
      )!,
      coachCardBackgroundColor: Color.lerp(
        coachCardBackgroundColor,
        other.coachCardBackgroundColor,
        t,
      )!,
      coachCardBorderColor: Color.lerp(
        coachCardBorderColor,
        other.coachCardBorderColor,
        t,
      )!,
      coachCardShadowColor: Color.lerp(
        coachCardShadowColor,
        other.coachCardShadowColor,
        t,
      )!,
    );
  }
}
