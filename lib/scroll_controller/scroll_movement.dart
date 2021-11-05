import 'package:flutter/material.dart';

class ScrollMovement extends StatefulWidget {
  @override
  _ScrollMovementState createState() => _ScrollMovementState();
}

class _ScrollMovementState extends State<ScrollMovement> {
  ScrollController? _controller;
  final itemSize = 100.0;

  _moveUp() {
    //_controller.jumpTo(_controller.offset - itemSize);
    _controller!.animateTo(_controller!.offset - itemSize,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  _moveDown() {
    //_controller.jumpTo(_controller.offset + itemSize);
    _controller!.animateTo(_controller!.offset + itemSize,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Movement"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    child: Text("up"),
                    onPressed: _moveUp,
                  ),
                  ElevatedButton(
                    child: Text("down"),
                    onPressed: _moveDown,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: 30,
              itemExtent: itemSize,
              itemBuilder: (context, index) {
                return ListTile(title: Text("Index : $index"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
