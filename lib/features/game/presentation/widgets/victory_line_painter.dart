import 'package:flutter/material.dart';

class VictoryLinePainter extends CustomPainter {
  VictoryLinePainter({
    required this.line,
    required this.color,
    required this.boardSize,
  });

  final List<(int, int)> line;
  final Color color;
  final double boardSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (line.length < 2) return;

    final cellSize = boardSize / 3;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final start = Offset(
      line.first.$2 * cellSize + cellSize / 2,
      line.first.$1 * cellSize + cellSize / 2,
    );
    final end = Offset(
      line.last.$2 * cellSize + cellSize / 2,
      line.last.$1 * cellSize + cellSize / 2,
    );

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant VictoryLinePainter oldDelegate) {
    return line != oldDelegate.line || color != oldDelegate.color;
  }
}
