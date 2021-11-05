import 'package:flutter/material.dart';

class ScrollLimitReached extends StatefulWidget {
  @override
  _ScrollLimitReachedState createState() => _ScrollLimitReachedState();
}

class _ScrollLimitReachedState extends State<ScrollLimitReached> {
  ScrollController? _controller;
  String message = "";

  _scrollListener() {
    if (_controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
      });
    }
    if (_controller!.offset <= _controller!.position.minScrollExtent &&
        !_controller!.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.removeListener(_scrollListener);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Limit reached"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Text(message),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: 30,
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
