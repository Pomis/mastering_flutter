import 'package:flutter/material.dart';
import 'package:mastering_flutter/button_style/selectable_button.dart';

class ButtonStyleExample extends StatelessWidget {
  const ButtonStyleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Style Example')),
      body: const SelectableButton(
        initialValue: false,
        childOn: Text("Power On"),
        childOff: Text(
          "Power Off",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
