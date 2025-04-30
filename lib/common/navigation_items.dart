
import 'package:flutter/material.dart';
import 'package:mastering_flutter/button_style/button_style_example.dart';
import 'package:mastering_flutter/common/navigation_item.dart';
import 'package:mastering_flutter/gestures/gestures_page.dart';
import 'package:mastering_flutter/gestures/hit_test_behavior_example.dart';
import 'package:mastering_flutter/input_decoration/input_decoration_example.dart';
import 'package:mastering_flutter/scrollable/scrollable_example.dart';
import 'package:mastering_flutter/shapes/shapes_example.dart';
import 'package:mastering_flutter/widget_state/widget_state_example.dart';

final navigationItems = [
  NavigationItem(
    title: "Widget State",
    subtitle: "Mastering Widget State",
    builder: (context) => const WidgetStateExample(),
  ),
  NavigationItem(
    title: "Gesture Detector",
    subtitle: "Mastering GestureDetector",
    builder: (context) => const GesturesPage(),
  ),
  NavigationItem(
    title: "Hit Test Behavior Example",
    subtitle: "Mastering GestureDetector",
    builder: (context) => const HitTestBehaviorExample(),
  ),
  NavigationItem(
    title: "Scrollable",
    subtitle: "Mastering Scrollable",
    builder: (context) => const ScrollableExample(physics: BouncingScrollPhysics()),
  ),
  NavigationItem(
    title: "Shapes and Clipping",
    subtitle: "Mastering Shapes and Clipping",
    builder: (context) => const ShapesExample(),
  ),
  NavigationItem(
    title: "Button Style",
    subtitle: "Mastering Button Style",
    builder: (context) => const ButtonStyleExample(),
  ),
  NavigationItem(
    title: "Input Decoration",
    subtitle: "Mastering Input Decoration",
    builder: (context) => const InputDecorationExample(),
  ),
  
];
