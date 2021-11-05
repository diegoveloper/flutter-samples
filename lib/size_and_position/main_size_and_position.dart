import 'package:flutter/material.dart';

class MainSizeAndPosition extends StatefulWidget {
  @override
  _MainSizeAndPositionState createState() => _MainSizeAndPositionState();
}

class _MainSizeAndPositionState extends State<MainSizeAndPosition> {
  GlobalKey _keyRed = GlobalKey();
  GlobalKey _keyPurple = GlobalKey();
  GlobalKey _keyGreen = GlobalKey();

  _getSizes() {
    final RenderBox renderBoxRed =
        _keyRed.currentContext!.findRenderObject() as RenderBox;
    final sizeRed = renderBoxRed.size;

    final RenderBox renderBoxPurple =
        _keyPurple.currentContext!.findRenderObject() as RenderBox;
    final sizePurple = renderBoxPurple.size;

    final RenderBox renderBoxGreen =
        _keyGreen.currentContext!.findRenderObject() as RenderBox;
    final sizeGreen = renderBoxGreen.size;

    print("SIZE of Red: $sizeRed");
    print("SIZE of Purple: $sizePurple");
    print("SIZE of Green: $sizeGreen");
  }

  _getPositions() {
    final RenderBox renderBoxRed =
        _keyRed.currentContext!.findRenderObject() as RenderBox;
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);

    final RenderBox renderBoxPurple =
        _keyPurple.currentContext!.findRenderObject() as RenderBox;
    final positionPurple = renderBoxPurple.localToGlobal(Offset.zero);

    final RenderBox renderBoxGreen =
        _keyGreen.currentContext!.findRenderObject() as RenderBox;
    final positionGreen = renderBoxGreen.localToGlobal(Offset.zero);

    print("POSITION of Red: $positionRed ");
    print("POSITION of Purple: $positionPurple ");
    print("POSITION of Green: $positionGreen ");
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              key: _keyRed,
              color: Colors.red,
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              key: _keyPurple,
              color: Colors.purple,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              key: _keyGreen,
              color: Colors.green,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  padding: EdgeInsets.all(15.0),
                  color: Colors.grey,
                  child: Text("Get Sizes"),
                  onPressed: _getSizes,
                ),
                MaterialButton(
                  elevation: 5.0,
                  color: Colors.grey,
                  padding: EdgeInsets.all(15.0),
                  child: Text("Get Positions"),
                  onPressed: _getPositions,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
