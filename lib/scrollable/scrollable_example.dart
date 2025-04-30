import 'package:flutter/material.dart';

class ScrollableExample extends StatefulWidget {
  final ScrollPhysics physics;

  const ScrollableExample({super.key, required this.physics});

  @override
  State<ScrollableExample> createState() => _ScrollableExampleState();
}

class _ScrollableExampleState extends State<ScrollableExample> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Scrollable"),),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          print("${notification.scrollDelta!}\t${notification.dragDetails}");
          return false;
        },
        child: _tr(),
      ),
    );
  }

  Widget _gestureTest() {
    return Center(
      child: Transform.scale(
        transformHitTests: true,
        scale: 2,
        child: GestureDetector(
          onTap: () => print("Tapped"),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _tr() {
    return ListView(
      controller: _controller,
      physics: widget.physics,
    
       children: [
        Container(height: 1000, color: Color(0xFF00dfff).withOpacity(0.2), child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(List.generate(20, (i) => "Text $i").join('\n'), style: TextStyle(fontSize: 22),),
        ),),
      ],
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({super.key});

  @override
  State<_Item> createState() => __ItemState();
}

class __ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    return Text("Text");
  }
}
