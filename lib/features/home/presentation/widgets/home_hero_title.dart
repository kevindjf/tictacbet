import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';

class HomeHeroTitleData {
  const HomeHeroTitleData({
    required this.line1,
    required this.line2,
    required this.subtitleLine1,
    required this.subtitleLine2,
    required this.accentColor,
    required this.secondaryAccentColor,
    this.showBolt = false,
  });

  final String line1;
  final String line2;
  final String subtitleLine1;
  final String subtitleLine2;
  final Color accentColor;
  final Color secondaryAccentColor;
  final bool showBolt;
}

class HomeHeroTitle extends StatelessWidget {
  const HomeHeroTitle({
    super.key,
    required this.data,
  });

  final HomeHeroTitleData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingM),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final line1Size = math.min(68.0, math.max(34.0, width * 0.15));
          final line2Size = math.min(60.0, math.max(30.0, width * 0.125));
          final boltSize = math.min(44.0, math.max(24.0, width * 0.1));

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: _PrimaryTitle(
                  text: data.line1,
                  fontSize: line1Size,
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Transform.rotate(
                  angle: _titleTiltAngle,
                  child: _GradientTitleLine(
                    text: data.line2,
                    fontSize: line2Size,
                    accentColor: data.accentColor,
                    secondaryAccentColor: data.secondaryAccentColor,
                    showBolt: data.showBolt,
                    boltSize: boltSize,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingS),
              _SubtitleBlock(
                textTheme: textTheme,
                line1: data.subtitleLine1,
                line2: data.subtitleLine2,
                accentColor: data.accentColor,
              ),
            ],
          )
              .animate(key: ValueKey('${data.line1}-${data.line2}'))
              .fadeIn(duration: 350.ms)
              .slideY(begin: 0.08, duration: 350.ms, curve: Curves.easeOut);
        },
      ),
    );
  }
}

class _PrimaryTitle extends StatelessWidget {
  const _PrimaryTitle({
    required this.text,
    required this.fontSize,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _titleTiltAngle,
      child: Text(
        text.toUpperCase(),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.visible,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          fontSize: fontSize,
          height: 0.9,
          fontStyle: FontStyle.italic,
          letterSpacing: -1.5,
          color: Colors.white,
          fontWeight: FontWeight.w900,
          shadows: const [
            Shadow(color: Color(0xFF202020), offset: Offset(0, 2), blurRadius: 0),
            Shadow(color: Color(0xFF1A1A1A), offset: Offset(0, 4), blurRadius: 0),
            Shadow(color: Color(0xE6000000), offset: Offset(0, 12), blurRadius: 8),
            Shadow(color: Color(0xCC000000), offset: Offset(0, 22), blurRadius: 24),
            Shadow(color: Color(0x99000000), offset: Offset(0, 32), blurRadius: 36),
          ],
        ),
      ),
    );
  }
}

class _GradientTitleLine extends StatelessWidget {
  const _GradientTitleLine({
    required this.text,
    required this.fontSize,
    required this.accentColor,
    required this.secondaryAccentColor,
    required this.showBolt,
    required this.boltSize,
  });

  final String text;
  final double fontSize;
  final Color accentColor;
  final Color secondaryAccentColor;
  final bool showBolt;
  final double boltSize;

  @override
  Widget build(BuildContext context) {
    final words = text.toUpperCase().split(' ');
    final left = words.isEmpty ? text : words.first;
    final right = words.length > 1 ? words.sublist(1).join(' ') : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _OutlinedGradientText(
          text: left,
          fontSize: fontSize,
          accentColor: accentColor,
          secondaryAccentColor: secondaryAccentColor,
        ),
        if (showBolt) ...[
          const SizedBox(width: 6),
          _BoltIcon(size: boltSize, color: secondaryAccentColor),
          const SizedBox(width: 6),
        ] else if (right.isNotEmpty) ...[
          const SizedBox(width: 8),
        ],
        if (right.isNotEmpty)
          _OutlinedGradientText(
            text: right,
            fontSize: fontSize,
            accentColor: accentColor,
            secondaryAccentColor: secondaryAccentColor,
          ),
      ],
    );
  }
}

class _OutlinedGradientText extends StatelessWidget {
  const _OutlinedGradientText({
    required this.text,
    required this.fontSize,
    required this.accentColor,
    required this.secondaryAccentColor,
  });

  final String text;
  final double fontSize;
  final Color accentColor;
  final Color secondaryAccentColor;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
      fontSize: fontSize,
      height: 0.9,
      fontStyle: FontStyle.italic,
      letterSpacing: -1.2,
      fontWeight: FontWeight.w900,
    );

    return Stack(
      children: [
        Text(
          text,
          style: baseStyle?.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3.5
              ..color = const Color(0xFF161616),
            shadows: const [
              Shadow(color: Color(0xFF161616), offset: Offset(0, 3), blurRadius: 0),
              Shadow(color: Color(0xFF101010), offset: Offset(0, 7), blurRadius: 0),
              Shadow(
                color: Color(0xE6000000),
                offset: Offset(0, 14),
                blurRadius: 10,
              ),
              Shadow(
                color: Color(0xB3000000),
                offset: Offset(0, 24),
                blurRadius: 22,
              ),
            ],
          ),
        ),
        Text(
          text,
          style: baseStyle?.copyWith(
            foreground: Paint()
              ..shader = LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  secondaryAccentColor.withValues(alpha: 0.95),
                  accentColor.withValues(alpha: 0.95),
                ],
              ).createShader(
                Rect.fromLTWH(0, 0, text.length * fontSize * 0.58, fontSize),
              ),
          ),
        ),
      ],
    );
  }
}

class _BoltIcon extends StatelessWidget {
  const _BoltIcon({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.bolt,
      size: size,
      color: color,
      shadows: [
        Shadow(color: color.withAlpha(180), blurRadius: 14),
        const Shadow(color: Color(0xB3000000), offset: Offset(0, 6), blurRadius: 10),
      ],
    )
        .animate(onPlay: (controller) => controller.repeat())
        .scaleXY(
          begin: 0.95,
          end: 1.05,
          duration: 550.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .scaleXY(
          begin: 1.05,
          end: 0.95,
          duration: 550.ms,
          curve: Curves.easeInOut,
        );
  }
}

class _SubtitleBlock extends StatelessWidget {
  const _SubtitleBlock({
    required this.textTheme,
    required this.line1,
    required this.line2,
    required this.accentColor,
  });

  final TextTheme textTheme;
  final String line1;
  final String line2;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _titleTiltAngle,
      child: Column(
        children: [
          Text(
            line1,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              letterSpacing: 1,
              shadows: const [
                Shadow(color: Color(0xCC000000), offset: Offset(0, 4), blurRadius: 10),
              ],
            ),
          ),
          Text(
            line2,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(
              color: accentColor,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: 1,
              shadows: [
                Shadow(color: accentColor.withAlpha(140), blurRadius: 12),
                const Shadow(color: Color(0xCC000000), offset: Offset(0, 4), blurRadius: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _titleTiltAngle = -0.045;
