import 'dart:math';

import 'package:flutter/material.dart';

class ScrollableColumn extends StatefulWidget {
  const ScrollableColumn({super.key});

  @override
  State<ScrollableColumn> createState() => _ScrollableZoomerState();
}

class _ScrollableZoomerState extends State<ScrollableColumn> {
  ValueNotifier<double> scrollPosition = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Example",
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Text("Content"),
                    const Spacer(),
                    Center(child: ElevatedButton(onPressed: () {}, child: Text("Button")))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}