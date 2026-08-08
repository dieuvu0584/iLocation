import 'dart:math';
import 'dart:ui';

/// Positions for N nodes on a ring of the given radius, relative to the
/// ring's center (SDD §6: "tính bằng lượng giác") — not forced to sit at
/// exactly equal angles/radius from the center (đợt 14, CLAUDE.md — "level
/// 2 nodes don't need to be evenly spaced from level 1"). Still
/// fundamentally a ring around the center (keeps the node-graph feel +
/// connector lines), just with a small deterministic per-node offset so it
/// doesn't look like a perfect uniform circle — useful now that some
/// groups have grown to 7-8 children, which crowds badly at exact even
/// spacing. Deterministic (based on index only) so the layout doesn't
/// jitter between rebuilds.
List<Offset> relaxedRingPositions(int count, double radius, {double startAngle = -pi / 2}) {
  if (count <= 0) return const [];
  final step = 2 * pi / count;
  const angleJitter = [-0.16, 0.05, 0.12];
  const radiusFactor = [1.0, 0.9, 1.06];
  return List.generate(count, (i) {
    final angle = startAngle + step * i + angleJitter[i % angleJitter.length];
    final r = radius * radiusFactor[i % radiusFactor.length];
    return Offset(r * cos(angle), r * sin(angle));
  });
}
