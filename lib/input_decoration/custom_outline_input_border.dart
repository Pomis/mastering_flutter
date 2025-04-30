
import 'package:flutter/material.dart';

class CustomOutlineInputBorder extends UnderlineInputBorder {
  final Gradient? gradient;

  const CustomOutlineInputBorder({
    super.borderRadius,
    super.borderSide,
    this.gradient,
  });

  static final Map<int, Paint> _paintCache = {};

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final RRect outer = borderRadius.toRRect(rect);
    final RRect center = outer.deflate(borderSide.width / 2.0);
    _paintCache[gradient.hashCode] ??= borderSide.toPaint()
      ..shader = gradient?.createShader(rect);

    canvas.drawRRect(center, _paintCache[gradient.hashCode]!);
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is CustomOutlineInputBorder) {
      return CustomOutlineInputBorder(
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        gradient: gradient is RadialGradient
            ? RadialGradient.lerp(
                a.gradient as RadialGradient, gradient as RadialGradient, t)
            : null,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is CustomOutlineInputBorder) {
      return CustomOutlineInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        gradient: gradient is RadialGradient
            ? RadialGradient.lerp(
                gradient as RadialGradient, b.gradient as RadialGradient, t)
            : null,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  bool operator ==(Object other) {
    if (other is CustomOutlineInputBorder) {
      return gradient == other.gradient &&
          borderSide == other.borderSide &&
          borderRadius == other.borderRadius;
    }

    return super == other;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius, gradient);
}
