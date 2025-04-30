import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MessageInputBorder extends OutlineInputBorder {
  final Color fillColor;
  final double weight;

  const MessageInputBorder({
    super.borderSide,
    super.borderRadius,
    this.weight = 2.5,
    required this.fillColor,
  });

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final strokeWidth = borderSide.width;

    final double left = rect.left + strokeWidth;
    final double right = rect.right - strokeWidth;
    final double top = rect.top + strokeWidth;
    final double bottom = rect.bottom - strokeWidth;

    final radius = max(0, borderRadius.bottomLeft.x - 10);
    final offset = 10;

    return Path()
      ..moveTo(left + offset + radius, bottom)
      ..conicTo(
        left + offset,
        bottom,
        left + offset,
        bottom - 2 * radius,
        weight,
      )
      ..lineTo(left + offset, top + radius)
      ..conicTo(left + offset, top, left + offset + radius, top, weight)
      ..lineTo(right - radius, top)
      ..conicTo(right, top, right, top + radius, weight)
      ..lineTo(right, bottom - radius)
      ..conicTo(right, bottom, right - radius, bottom, weight)
      ..close();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double left = rect.left;
    final double right = rect.right;
    final double top = rect.top;
    final double bottom = rect.bottom;

    final radius = borderRadius.bottomLeft.x;
    final offset = 10;

    return Path()
      ..moveTo(left, bottom)
      ..conicTo(
        left + offset,
        bottom - offset,
        left + offset,
        bottom - 2 * radius,
        weight,
      )
      ..lineTo(left + offset, top + radius)
      ..conicTo(left + offset, top, left + offset + radius, top, weight)
      ..lineTo(right - radius, top)
      ..conicTo(right, top, right, top + radius, weight)
      ..lineTo(right, bottom - radius)
      ..conicTo(right, bottom, right - radius, bottom, weight)
      ..close();
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    canvas.drawPath(
      getOuterPath(rect),
      Paint()..color = borderSide.color,
    );
    canvas.drawPath(getInnerPath(rect), Paint()..color = fillColor);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is MessageInputBorder) {
      return MessageInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
        weight: lerpDouble(weight, b.weight, t)!,
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        fillColor: Color.lerp(fillColor, b.fillColor, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    return lerpTo(a, 1 - t);
  }

  @override
  OutlineInputBorder scale(double t) {
    return MessageInputBorder(
      borderRadius: BorderRadius.lerp(borderRadius, borderRadius, t)!,
      weight: weight * t,
      borderSide: BorderSide.lerp(borderSide, borderSide, t),
      fillColor: Color.lerp(fillColor, fillColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is MessageInputBorder) {
      return weight == other.weight &&
          borderRadius == other.borderRadius &&
          borderSide == other.borderSide &&
          fillColor == other.fillColor;
    }
    return super == other;
  }

  @override
  int get hashCode => Object.hash(weight, borderRadius, borderSide, fillColor);
}
