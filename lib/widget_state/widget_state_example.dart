import 'package:flutter/material.dart';
import 'package:mastering_flutter/widget_state/tap_area_2.dart';

import 'card_example.dart';

class WidgetStateExample extends StatefulWidget {
  const WidgetStateExample({super.key});

  @override
  State<WidgetStateExample> createState() => _WidgetStateExampleState();
}

class _WidgetStateExampleState extends State<WidgetStateExample> {
  final _statesController = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget State Example'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(40),

          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              overlayColor: WidgetStateColor.fromMap({
                WidgetState.pressed | WidgetState.hovered: Colors.blue,
                WidgetState.any: Colors.white,
              }),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("InkWell"),
              ),
            ),
            const SizedBox(height: 40),
ElevatedButton(
  style: ButtonStyle(
    side: WidgetStateBorderSide.fromMap({
      WidgetState.hovered: BorderSide(color: Colors.white, width: 3),
      WidgetState.any: BorderSide(color: Colors.blueGrey, width: 1),
    }),
    shadowColor: WidgetStateColor.fromMap({
      WidgetState.hovered: Colors.blueGrey.withValues(alpha: 0.5),
      WidgetState.any: Colors.blueGrey.withValues(alpha: 0.1),
    }),
    backgroundColor: WidgetStateColor.fromMap({
      WidgetState.any: Colors.white,
    }),
    textStyle: WidgetStateTextStyle.fromMap({
      WidgetState.pressed: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      WidgetState.any: const TextStyle(fontWeight: FontWeight.bold,),
    }),
  ),
  onPressed: () {},
  child: Text("ElevatedButton"),
),
            ListTile(
              enabled: false,
              title: Text("Title"),
              subtitle: Text("Subtitle"),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              enabled: true,
              title: Text("Title"),
              subtitle: Text("Subtitle"),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(height: 40),
            Checkbox(value: false, onChanged: (_) {}),
            Checkbox(value: true, onChanged: (_) {}),
            Checkbox(value: true, onChanged: null),

            const SizedBox(height: 40),

            Switch(
              trackColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered)) {
                  return Colors.lightBlue;
                }
                return Colors.blue;
              }),
              value: true,
              onChanged: (_) {},
            ),
            const SizedBox(height: 40),
            const CardExample(),
            const SizedBox(height: 40),
            _ButtonExample(statesController: _statesController),
            const SizedBox(height: 40),
            TapArea2(
              style: TapAreaStyle(
                opacity: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return 0.5;
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return 0.9;
                  }
                  return 1.0;
                }),
                foregroundHighlight: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.hovered)) {
                    return 0.1;
                  }
                  return 0.0;
                }),
              ),
              padding: EdgeInsets.all(20),
              child: Text("Tap area"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonExample extends StatelessWidget {
  const _ButtonExample({
    super.key,
    required WidgetStatesController statesController,
  }) : _statesController = statesController;

  final WidgetStatesController _statesController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      statesController: _statesController,
      style: ButtonStyle(
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return const BorderSide(color: Colors.black);
          }
          if (states.contains(WidgetState.hovered)) {
            return const BorderSide(color: Colors.deepPurple);
          }
          return null;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return Colors.black12;
          }
          return Colors.transparent;
        }),
      ),
      onPressed: () {},
      child: Text("ABC"),
    );
  }
}
