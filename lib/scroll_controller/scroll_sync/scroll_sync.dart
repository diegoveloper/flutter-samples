import 'package:flutter/material.dart';

class ScrollSync extends StatefulWidget {
  @override
  _ScrollSyncState createState() => _ScrollSyncState();
}

class _ScrollSyncState extends State<ScrollSync> {
  CustomScrollController _controller1 = CustomScrollController();
  CustomScrollController _controller2 = CustomScrollController();

  @override
  void initState() {
    _controller1.addListener(() => _controller2
        .jumpToWithoutGoingIdleAndKeepingBallistic(_controller1.offset));
    _controller2.addListener(() => _controller1
        .jumpToWithoutGoingIdleAndKeepingBallistic(_controller2.offset));
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Sync"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: ListView.builder(
              controller: _controller1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Container(
                color: Colors.red,
                width: 150,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "$index",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: ListView.builder(
              controller: _controller2,
              itemBuilder: (_, index) => Container(
                color: Colors.black,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "$index",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomScrollController extends ScrollController {
  CustomScrollController({
    double initialScrollOffset = 0.0,
    keepScrollOffset = true,
    debugLabel,
  }) : super(
            initialScrollOffset: initialScrollOffset,
            keepScrollOffset: keepScrollOffset,
            debugLabel: debugLabel);

  @override
  _SilentScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _SilentScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      initialPixels: initialScrollOffset,
    );
  }

  void jumpToWithoutGoingIdleAndKeepingBallistic(double value) {
    assert(positions.isNotEmpty, 'ScrollController not attached.');
    for (_SilentScrollPosition position
        in new List<ScrollPosition>.from(positions)
            as Iterable<_SilentScrollPosition>)
      position.jumpToWithoutGoingIdleAndKeepingBallistic(value);
  }
}

class _SilentScrollPosition extends ScrollPositionWithSingleContext {
  _SilentScrollPosition({
    required ScrollPhysics physics,
    required ScrollContext context,
    ScrollPosition? oldPosition,
    double? initialPixels,
  }) : super(
          physics: physics,
          context: context,
          oldPosition: oldPosition,
          initialPixels: initialPixels,
        );

  void jumpToWithoutGoingIdleAndKeepingBallistic(double value) {
    if (pixels != value) {
      forcePixels(value);
    }
  }
}
