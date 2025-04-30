import 'package:flutter/material.dart';
import 'package:mastering_flutter/gestures/custom_button.dart';
import 'package:mastering_flutter/gestures/custom_scale_detector.dart';
import 'package:mastering_flutter/gestures/custom_tap_detector.dart';
import 'package:mastering_flutter/gestures/hit_test_behavior_example.dart';
import 'package:mastering_flutter/gestures/pan_detector.dart';
import 'package:mastering_flutter/gestures/transform_scale_detector.dart';

class GesturesPage extends StatelessWidget {
  const GesturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gesture Detector Example"),
      ),
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
            PanDetector(
              child: Container(
                height: 100,
                width: 300,
                color: Colors.black12,
              ),
            ),
            CustomGestureButton(
              onTap: () => print("Tapped"),
            ),
            const SizedBox(height: 20),
            const CustomScaleDetector(),
            const SizedBox(height: 20),
            const TransformScaleDetector(),
            HitTestBehaviorExample(),
          ],
        ),
      ),
    );
  }
}
