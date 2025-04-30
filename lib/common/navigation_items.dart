
import 'package:mastering_flutter/button_style/button_style_example.dart';
import 'package:mastering_flutter/common/navigation_item.dart';
import 'package:mastering_flutter/input_decoration/input_decoration_example.dart';
import 'package:mastering_flutter/widget_state/widget_state_example.dart';

final navigationItems = [
  NavigationItem(
    title: "Widget State",
    subtitle: "Basics of Widget State",
    builder: (context) => const WidgetStateExample(),
  ),
  NavigationItem(
    title: "Button Style",
    subtitle: "Basics of Button Style",
    builder: (context) => const ButtonStyleExample(),
  ),
  NavigationItem(
    title: "Input Decoration",
    subtitle: "Basics of Input Decoration",
    builder: (context) => const InputDecorationExample(),
  ),
  
];
