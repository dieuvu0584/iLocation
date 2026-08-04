import 'dart:math';
import 'dart:ui';

/// Positions for N nodes evenly spaced on a ring of the given radius,
/// relative to the ring's center (SDD §6: "tính bằng lượng giác").
List<Offset> ringPositions(int count, double radius, {double startAngle = -pi / 2}) {
  if (count <= 0) return const [];
  final step = 2 * pi / count;
  return List.generate(count, (i) {
    final angle = startAngle + step * i;
    return Offset(radius * cos(angle), radius * sin(angle));
  });
}
