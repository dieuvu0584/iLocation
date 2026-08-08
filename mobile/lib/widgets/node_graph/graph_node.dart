import 'dart:math';

import 'package:flutter/material.dart';

import '../../theme/colors.dart';

/// Center node: breathing glow + expanding "ping" ring when ambient motion
/// is enabled (SDD §6). `animation` is a shared, looping 0..1 controller so
/// every node in the graph animates off one ticker instead of many.
class CenterNode extends StatelessWidget {
  final String label;
  final String? sublabel;
  final Animation<double> animation;
  final bool reducedMotion;
  final VoidCallback? onTap;

  const CenterNode({
    super.key,
    required this.label,
    this.sublabel,
    required this.animation,
    required this.reducedMotion,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final t = animation.value;
        final glow = reducedMotion ? 0.55 : 0.4 + 0.25 * sin(2 * pi * t);
        final pingT = reducedMotion ? 0.0 : t;
        return SizedBox(
          width: 176,
          height: 176,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (!reducedMotion)
                Opacity(
                  opacity: (1 - pingT).clamp(0.0, 1.0) * 0.35,
                  child: Transform.scale(
                    scale: 0.75 + pingT * 0.55,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(BorderSide(color: AppColors.accentAmber, width: 1.5)),
                      ),
                    ),
                  ),
                ),
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [AppColors.accentAmber.withValues(alpha: glow + 0.4), AppColors.accentAmberDark],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppColors.accentAmber.withValues(alpha: glow * 0.55), blurRadius: 28, spreadRadius: 2),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onTap,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              label,
                              textAlign: TextAlign.center,
                              maxLines: sublabel == null ? 3 : 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: AppColors.bgDark, fontWeight: FontWeight.w700),
                            ),
                            if (sublabel != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                sublabel!,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.bgDark.withValues(alpha: 0.7),
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// One node on the outer ring (tier-1 group or tier-2 detail item). Floats
/// gently up/down out of phase with its siblings when ambient motion is on.
class RingNode extends StatelessWidget {
  final String label;
  final IconData icon;
  final Offset basePosition;
  final Animation<double> animation;
  final double phase;
  final bool reducedMotion;
  final bool isLoading;
  final bool hasWarning;
  final VoidCallback? onTap;

  const RingNode({
    super.key,
    required this.label,
    required this.icon,
    required this.basePosition,
    required this.animation,
    required this.phase,
    required this.reducedMotion,
    this.isLoading = false,
    this.hasWarning = false,
    this.onTap,
  });

  static const double size = 96;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final floatOffset = reducedMotion ? 0.0 : 6 * sin(2 * pi * animation.value + phase);
        return Positioned(
          left: basePosition.dx - size / 2,
          top: basePosition.dy - size / 2 + floatOffset,
          child: child!,
        );
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Material(
          color: AppColors.cardBg1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: onTap,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accentAmber),
                        )
                      else
                        Icon(icon, color: AppColors.accentAmber, size: 22),
                      const SizedBox(height: 6),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
                if (hasWarning)
                  const Positioned(
                    top: 6,
                    right: 6,
                    child: Icon(Icons.error_outline, size: 14, color: AppColors.error),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
