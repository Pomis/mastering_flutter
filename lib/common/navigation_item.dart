import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final String subtitle;
  final Widget Function(BuildContext context) builder;

  const NavigationItem({
    required this.title,
    required this.subtitle,
    required this.builder,
  });

  Future<void> navigate(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: builder),
    );
  }
}
