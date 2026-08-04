import 'dart:math';

import 'package:flutter/rendering.dart';

import '../../theme/colors.dart';

/// Draws the lines from the center node to each ring node, with a subtle
/// pulsing opacity per-line when ambient motion is enabled (SDD §6).
class ConnectorPainter extends CustomPainter {
  final List<Offset> targets;
  final double animationValue;
  final bool reducedMotion;

  ConnectorPainter({required this.targets, required this.animationValue, required this.reducedMotion});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < targets.length; i++) {
      final target = center + targets[i];
      final pulse = reducedMotion ? 0.55 : 0.4 + 0.3 * sin(2 * pi * animationValue + i * 0.6);
      final paint = Paint()
        ..color = AppColors.borderColor.withValues(alpha: pulse.clamp(0.0, 1.0))
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      canvas.drawLine(center, target, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConnectorPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue ||
      oldDelegate.reducedMotion != reducedMotion ||
      oldDelegate.targets.length != targets.length;
}
