import 'dart:math';

import 'package:flutter/material.dart';

class SelectableButton extends StatefulWidget {
  final bool initialValue;
  final Function(bool isPressed)? onPressed;
  final Widget childOn;
  final Widget childOff;

  const SelectableButton({
    super.key,
    required this.initialValue,
    this.onPressed,
    required this.childOn,
    required this.childOff,
  });

  @override
  State<SelectableButton> createState() => _SelectableButtonState();
}

const Color _white = Color(0xFFFFFFFF);
const Color _darkBlue = Color(0xFF212936);
const Color _green = Color(0xFF43946C);

class _SelectableButtonState extends State<SelectableButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkAnimationController;
  late WidgetStatesController _statesController;

  bool get _isSelected =>
      _statesController.value.contains(WidgetState.selected);

  bool get _isPressed => _statesController.value.contains(WidgetState.pressed);

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController()
      ..update(
        WidgetState.selected,
        widget.initialValue,
      );

    _blinkAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      statesController: _statesController,
      style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return 0;
          }

          return 8;
        }),
        shadowColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _green.withValues(alpha: 0.5);
          }

          return _darkBlue.withValues(alpha: 0.5);
        }),
backgroundBuilder: (context, states, child) {
  final color =
      states.contains(WidgetState.selected) ? _green : _darkBlue;
  return AnimatedContainer(
    duration: kThemeAnimationDuration,
    decoration: BoxDecoration(
      color: color,
      gradient: RadialGradient(
        focal: Alignment(_isSelected ? -1.1 : 1.1, -1),
        colors: [
          color.increaseLightness(_isPressed ? 0.2 : 0.1).increaseSaturation(_isPressed ? 0.2 : 0.1),
          color.withValues(alpha: 1),
        ],
        radius: 3.5,
        center: Alignment.bottomCenter,
      ),
    ),
    child: child,
  );
},
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          );
        }),
        foregroundBuilder: (context, states, child) {
          if (states.contains(WidgetState.hovered)) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: _white.withValues(alpha: 0.2),
                backgroundBlendMode: BlendMode.overlay,
              ),
              child: child,
            );
          }

          return child!;
        },
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return _white.withValues(alpha: 0.5);
          }

          return Colors.white;
        }),
      ),
      onPressed: () {
        _statesController.update(WidgetState.selected, !_isSelected);
        widget.onPressed?.call(_isSelected);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListenableBuilder(
          listenable: _statesController,
          builder: (context, _) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedCrossFade(
                firstChild: const _IndicatorOff(),
                secondChild: _IndicatorOn(
                    animationController: _blinkAnimationController),
                crossFadeState: _isSelected
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: kThemeAnimationDuration,
              ),
              const SizedBox(width: 8),
              MaxWidthPreservingSwitch(
                showFirst: _isSelected,
                firstChild: widget.childOn,
                secondChild: widget.childOff,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void didUpdateWidget(ButtonStyleButton oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  // }
}

class _IndicatorOff extends StatelessWidget {
  const _IndicatorOff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _white.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
    );
  }
}

class _IndicatorOn extends StatefulWidget {
  final AnimationController animationController;

  const _IndicatorOn({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  State<_IndicatorOn> createState() => _IndicatorOnState();
}

class _IndicatorOnState extends State<_IndicatorOn> {
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return AnimatedOpacity(
          opacity: _opacityAnimation.value,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }


}

extension on Color {
  Color increaseSaturation(double amount) {
    final hsl = HSLColor.fromColor(this);
    final newSaturation = min(1.0, hsl.saturation + amount);
    return hsl.withSaturation(newSaturation).toColor();
  }

  Color increaseLightness(double amount) {
    final hsl = HSLColor.fromColor(this);
    final newLightness = min(1.0, hsl.lightness + amount);
    return hsl.withLightness(newLightness).toColor();
  }
}

class MaxWidthPreservingSwitch extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  final bool showFirst;

  const MaxWidthPreservingSwitch({
    super.key,
    required this.firstChild,
    required this.secondChild,
    required this.showFirst,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility.maintain(
          visible: showFirst,
          child: firstChild,
        ),
        Visibility.maintain(
          visible: !showFirst,
          child: secondChild,
        ),
      ],
    );
  }
}
