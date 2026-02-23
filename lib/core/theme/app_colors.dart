import 'package:flutter/material.dart';

abstract final class AppColors {
  // Dark theme
  static const Color darkBackground = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkCard = Color(0xFF1C2128);
  static const Color darkBorder = Color(0xFF30363D);

  // Light theme
  static const Color lightBackground = Color(0xFFF6F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFD0D7DE);

  // Accents
  static const Color betclicRed = Color(0xFFE63946);
  static const Color betclicRedButton = Color(0xFFD92D3A); // better contrast with white
  static const Color gold = Color(0xFFFFD700);
  static const Color goldDark = Color(0xFFB8960C);

  // Players
  static const Color playerX = Color(0xFF4ECDC4);
  static const Color playerO = Color(0xFFFF6B6B);

  // Neon accents (home carousel)
  static const Color neonRed = Color(0xFFFF0055);
  static const Color neonBlue = Color(0xFF00F2FF);
  static const Color neonGold = Color(0xFFFFCC00);

  // Semantic
  static const Color success = Color(0xFF2EA043);
  static const Color error = Color(0xFFDA3633);
  static const Color warning = Color(0xFFD29922);

  // Text
  static const Color darkTextPrimary = Color(0xFFE6EDF3);
  static const Color darkTextSecondary = Color(0xFF8B949E);
  static const Color lightTextPrimary = Color(0xFF1F2328);
  static const Color lightTextSecondary = Color(0xFF656D76);
}
