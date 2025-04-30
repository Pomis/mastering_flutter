import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mastering_flutter/shapes/message_input_border.dart';
import 'dart:math' as math;

import 'ticket_item.dart';

class ShapesExample extends StatefulWidget {
  const ShapesExample({super.key});

  @override
  State<ShapesExample> createState() => _ShapesExampleState();
}

class _ShapesExampleState extends State<ShapesExample> {
  final dateIndicatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Shapes and Clipping example")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _beveledBox(),
          const SizedBox(height: 20),
          _simpleRoundedBox(),
          const SizedBox(height: 20),
          _star(),
          const SizedBox(height: 20),
          _item4(),
          const SizedBox(height: 20),
          _textField(),
          const SizedBox(height: 20),
          _item5(),
          const SizedBox(height: 20),
          // _item7(),
          const SizedBox(height: 20),
          // _item8(),
        ],
      ),
    );
  }

  Widget _beveledBox() {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: Color(0xFFd6f5ff),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const SizedBox(height: 50),
    );
  }

  Widget _simpleRoundedBox() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFd6f5ff),
      ),
      child: const SizedBox(height: 50),
    );
  }

  Widget _star() {
    return DecoratedBox(
      decoration: ShapeDecoration(shape: StarBorder(), color: Colors.amber),
      child: const SizedBox(height: 100, width: 100),
    );
  }

  Widget _item4() {
    return MessageBubble(text: "Sample message text");
  }

  Widget _item5() {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: MessageShapeBorder(
          borderRadius: 50,
          side: BorderSide(width: 0, color: Color(0xFF7ADEFF)),
        ),
        color: Color(0xFF7ADEFF),
      ),
      child: SizedBox(width: 500, height: 200),
    );
  }

  Widget _textField() {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        enabledBorder: MessageInputBorder(
          borderRadius: BorderRadius.circular(50),
          weight: 2.5,
          fillColor: Color(0xFF7ADEFF),
          borderSide: BorderSide(color: Color(0xFFd6f5ff), width: 5),
        ),
        focusedBorder: MessageInputBorder(
          borderRadius: BorderRadius.circular(50),
          weight: 5,
          fillColor: Color(0xFFe6f6ff),
          borderSide: BorderSide(color: Color(0xFF6AD7F7), width: 4),
        ),
        hintText: "Message",
      ),
    );
  }

  Widget _item7() {
    return ClipPath(
      clipper: const ShapeBorderClipper(shape: MessageShapeBorder()),
      child: Image.asset(
        "assets/6392956.jpg",
        height: 200,
        width: 300,
        fit: BoxFit.cover,
        cacheHeight: (300 * MediaQuery.of(context).devicePixelRatio).toInt(),
      ),
    );
  }

  Widget _item8() {
    return TicketItem(
      topChild: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [Text("Top child")]),
      ),
      bottomChild: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback:
            (rectangle) => LinearGradient(
              begin: Alignment.topCenter,
              stops: [0, 1],
              colors: [Color(0xFFd6f5ff), Color(0x00d6f5ff)],
              end: Alignment.bottomCenter,
            ).createShader(rectangle),
        child: Image.asset(
          "assets/6392956.jpg",
          height: 200,
          width: 300,
          fit: BoxFit.cover,
          cacheHeight: (300 * MediaQuery.of(context).devicePixelRatio).toInt(),
        ),
      ),
    );
  }
}

class MessageBubble extends StatefulWidget {
  final String text;
  const MessageBubble({super.key, required this.text});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() => isPressed = true),
      onTapUp: (details) => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
              color: Colors.blueGrey.withValues(alpha: 0.4),
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
          shape: MessageShapeBorder(
            side: BorderSide(color: Color(0xFF7ADEFF), width: 5),
            weight: isPressed ? 8.0 : 2.5,
            borderRadius: 30,
          ),
          color: const Color(0xFFd6f5ff),
        ),
        child: Padding(
          padding: EdgeInsets.all(16).copyWith(left: 24),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class MessageShapeBorder extends OutlinedBorder {
  final double borderRadius;
  final double weight;

  const MessageShapeBorder({
    super.side,
    this.borderRadius = 50,
    this.weight = 2.5,
  });

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final strokeWidth = side.width;

    final double left = rect.left + strokeWidth;
    final double right = rect.right - strokeWidth;
    final double top = rect.top + strokeWidth;
    final double bottom = rect.bottom - strokeWidth;

    final radius = math.max(0, borderRadius - 10);
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

    final radius = borderRadius;
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
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    canvas.drawPath(getInnerPath(rect), Paint()..color = side.color);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is MessageShapeBorder) {
      return MessageShapeBorder(
        borderRadius: lerpDouble(borderRadius, b.borderRadius, t)!,
        weight: lerpDouble(weight, b.weight, t)!,
        side: BorderSide.lerp(side, b.side, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    return lerpTo(a, 1 - t);
  }

  @override
  OutlinedBorder scale(double t) {
    return MessageShapeBorder(
      borderRadius: borderRadius * t,
      weight: weight * t,
    );
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return MessageShapeBorder(side: side ?? this.side);
  }
}
