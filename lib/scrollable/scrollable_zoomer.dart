import 'dart:math';

import 'package:flutter/material.dart';

class ScrollableZoomer extends StatefulWidget {
  const ScrollableZoomer({super.key});

  @override
  State<ScrollableZoomer> createState() => _ScrollableZoomerState();
}

class _ScrollableZoomerState extends State<ScrollableZoomer> {
  ValueNotifier<double> scrollPosition = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ValueListenableBuilder(
            valueListenable: scrollPosition,
            builder: (context, value, _) => Opacity(
              opacity: value > 0.1 ? value : 0,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - value)),
                child: TextButton(
                  onPressed: () {},
                  child: Text("Next"),
                ),
              ),
            ),
          )
        ],
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
            scrollPosition.value = min(1, notification.metrics.pixels /
                notification.metrics.maxScrollExtent);

          return true;
        },
        child: const _ContentList(),
      ),
    );
  }
}

class _ContentList extends StatelessWidget {
  const _ContentList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      prototypeItem: _item(null),
      itemBuilder: (context, index) {
        return _item(index);
      },
    );
  }

  Widget _item(int? index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Card $index"),
      ),
    );
  }
}
