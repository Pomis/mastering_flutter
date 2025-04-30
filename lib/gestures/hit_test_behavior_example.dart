import 'package:flutter/material.dart';

class HitTestBehaviorExample extends StatelessWidget {
  const HitTestBehaviorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onPanStart: (details) => print('onPanStart A'),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (details) => print('onPanStart B'),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.add,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return ListView(
      children: [],
    );

    return SizedBox(
      height: 170,
      width: 170,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: _Box(
                  color: Colors.red, text: "A", onTap: () => print("onTap"))),
          Positioned(
              bottom: 0,
              right: 0,
              child: _Box(
                color: Colors.blue.withOpacity(0.6),
                text: "B",
                onPanUpdate: print,
              )),
        ],
      ),
    );

    return ColoredBox(
      color: Colors.greenAccent,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          print('onTap');
        },
        child: Padding(
          padding: EdgeInsets.all(100),
          child: Container(
            color: Colors.green,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onTap;
  final GestureDragUpdateCallback? onPanUpdate;

  const _Box(
      {required this.color, required this.text, this.onTap, this.onPanUpdate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      onTap: onTap,
      child: Container(
        color: color,
        width: 100,
        height: 100,
        child: Center(child: Text(text)),
      ),
    );
  }
}
