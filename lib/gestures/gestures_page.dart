import 'package:flutter/material.dart';
import 'package:mastering_flutter/gestures/custom_button.dart';
import 'package:mastering_flutter/gestures/custom_tap_detector.dart';
import 'package:mastering_flutter/gestures/hit_test_behavior_example.dart';

class GesturesPage extends StatelessWidget {
  const GesturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSlopeTapDetector(
              onTap: () => print("Tapped"),
              factor: 2,
              child: Container(
                width: 100,
                height: 20,
                color: Colors.red,
              ),
            ),
            // PanDetector(
            //   child: Container(
            //     height: 300,
            //     width: 300,
            //     color: Colors.black12,
            //   ),
            // ),
            CustomGestureButton(
              onTap: () => print("Tapped"),
            ),
            const SizedBox(height: 100),
            // const CustomScaleDetector(),
            const SizedBox(height: 20),
            // const TransformScaleDetector(),
            HitTestBehaviorExample(),
          ],
        ),
      ),
    );
  }
}
