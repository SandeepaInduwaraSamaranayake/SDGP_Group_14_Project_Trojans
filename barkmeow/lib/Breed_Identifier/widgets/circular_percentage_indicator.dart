import 'package:flutter/material.dart';
import 'dart:math' as math;

class PercentageIndicator extends StatelessWidget {
  final List percentages; // list of percentage values
  final List colors; // list of corresponding colors
  final double size; // width and height of the widget
  final double strokeWidth; // stroke width of the widget

  const PercentageIndicator({
    super.key,
    required this.percentages,
    required this.colors,
    required this.size,
    this.strokeWidth = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CircularPercentagePainter(
          percentages: percentages,
          colors: colors,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _CircularPercentagePainter extends CustomPainter {
  List percentages;
  final List colors;
  final double strokeWidth;

  _CircularPercentagePainter({
    required this.percentages,
    required this.colors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    double currentAngle = -math.pi / 2;
    for (int i = 0; i < percentages.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;

      final sweepAngle = percentages[i] * 2 * math.pi / 100;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweepAngle,
        false,
        paint,
      );

      currentAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
