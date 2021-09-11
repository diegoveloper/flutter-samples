import 'package:flutter/material.dart';
import 'dart:math';

class FoldablePage extends StatefulWidget {
  @override
  _FoldableState createState() => _FoldableState();
}

class _FoldableState extends State<FoldablePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _controller.forward(from: 0.0);
            },
            icon: Icon(Icons.star_border),
          ),
          IconButton(
            onPressed: () {
              _controller.reverse();
            },
            icon: Icon(Icons.restore),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(8.0),
                          child: Image.network(
                            "https://www.educaciontrespuntocero.com/wp-content/uploads/2018/01/machu-picchu.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        FoldableItem(
                          lastChild: Container(
                            color: Colors.red,
                            child: FlutterLogo(),
                          ),
                          animation:
                              Tween<double>(begin: 90.0, end: 0.0).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(0.6, 1.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: FoldableItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          "https://www.educaciontrespuntocero.com/wp-content/uploads/2018/01/chichen-itza.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      animation: Tween<double>(begin: 0.0, end: 90).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(0.3, 0.6),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoldableItem(
                      first: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          "https://www.educaciontrespuntocero.com/wp-content/uploads/2018/01/cristo-redentor-1.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      animation: Tween<double>(begin: 0.0, end: 180).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(0.0, 0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoldableItem extends AnimatedWidget {
  final Animation<double> animation;
  final Widget? child;
  final Widget? lastChild;
  final bool first;
  final double fullAngle = 180.0;
  final double halfAngle = 180.0 / 2.0;
  bool get hasLastChild => lastChild != null;

  FoldableItem({
    required this.animation,
    this.child,
    this.first = false,
    this.lastChild,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return animation.value == fullAngle && !hasLastChild
        ? SizedBox.shrink()
        : Transform(
            alignment:
                hasLastChild ? Alignment.bottomCenter : Alignment.topCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX((pi / fullAngle) *
                  (hasLastChild ? animation.value : -animation.value)),
            child: Container(
              color: (animation.value < halfAngle && first) ||
                      (!first && animation.value == 0.0)
                  ? Colors.red
                  : Colors.red[800],
              child: (first && animation.value < halfAngle ||
                      (animation.value == 0.0 && !hasLastChild))
                  ? child
                  : lastChild,
            ),
          );
  }
}
