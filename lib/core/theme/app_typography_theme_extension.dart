import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypographyTheme extends ThemeExtension<AppTypographyTheme> {
  const AppTypographyTheme({required this.homeLogoStyle});

  final TextStyle homeLogoStyle;

  static final AppTypographyTheme dark = AppTypographyTheme(
    homeLogoStyle: GoogleFonts.oswald(
      fontSize: 24,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
  );

  static final AppTypographyTheme light = AppTypographyTheme(
    homeLogoStyle: GoogleFonts.oswald(
      fontSize: 24,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
  );

  @override
  AppTypographyTheme copyWith({TextStyle? homeLogoStyle}) {
    return AppTypographyTheme(
      homeLogoStyle: homeLogoStyle ?? this.homeLogoStyle,
    );
  }

  @override
  AppTypographyTheme lerp(covariant AppTypographyTheme? other, double t) {
    if (other == null) return this;
    return AppTypographyTheme(
      homeLogoStyle: TextStyle.lerp(homeLogoStyle, other.homeLogoStyle, t)!,
    );
  }
}
