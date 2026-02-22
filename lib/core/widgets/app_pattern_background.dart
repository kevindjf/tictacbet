import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/widgets/grid_pattern_painter.dart';

class AppPatternBackground extends StatelessWidget {
  const AppPatternBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark
        ? theme.colorScheme.onSurface
        : theme.colorScheme.outlineVariant;
    final lineColor = baseColor.withAlpha(isDark ? 12 : 8);

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: GridPatternPainter(
              lineColor: lineColor,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
