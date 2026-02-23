import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const Color homeHeroStroke = Color(0xFF161616);
  static const Color homeHeroStrokeSecondary = Color(0xFF101010);
  static const Color depthBlack90 = Color(0xE6000000);
  static const Color depthBlack80 = Color(0xCC000000);
  static const Color depthBlack70 = Color(0xB3000000);
  static const Color depthBlack60 = Color(0x99000000);
  static const Color depthGrayTop = Color(0xFF202020);
  static const Color depthGrayMid = Color(0xFF1A1A1A);

  static const List<Shadow> homeHeroPrimaryTitle = [
    Shadow(color: depthGrayTop, offset: Offset(0, 2), blurRadius: 0),
    Shadow(color: depthGrayMid, offset: Offset(0, 4), blurRadius: 0),
    Shadow(color: depthBlack90, offset: Offset(0, 12), blurRadius: 8),
    Shadow(color: depthBlack80, offset: Offset(0, 22), blurRadius: 24),
    Shadow(color: depthBlack60, offset: Offset(0, 32), blurRadius: 36),
  ];

  static const List<Shadow> homeHeroOutlineTitle = [
    Shadow(color: homeHeroStroke, offset: Offset(0, 3), blurRadius: 0),
    Shadow(color: homeHeroStrokeSecondary, offset: Offset(0, 7), blurRadius: 0),
    Shadow(color: depthBlack90, offset: Offset(0, 14), blurRadius: 10),
    Shadow(color: depthBlack70, offset: Offset(0, 24), blurRadius: 22),
  ];

  static const List<Shadow> homeHeroSubtitle = [
    Shadow(color: depthBlack80, offset: Offset(0, 4), blurRadius: 10),
  ];

  static const Shadow homeHeroBoltDepth = Shadow(
    color: depthBlack70,
    offset: Offset(0, 6),
    blurRadius: 10,
  );
}
