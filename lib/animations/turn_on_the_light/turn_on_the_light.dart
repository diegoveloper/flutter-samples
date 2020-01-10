import 'package:flutter/material.dart';

class TurnOnTheLight extends StatefulWidget {
  @override
  _TurnOnTheLightState createState() => _TurnOnTheLightState();
}

class _TurnOnTheLightState extends State<TurnOnTheLight> {
  double x = 0, y = 0;
  final radius = 60.0;
  bool lightOn = false;

  void _onPanUpdate(Offset offset) {
    setState(() {
      lightOn = true;
      x = offset.dx;
      y = offset.dy;
    });
  }

  void _onPanEnd(_) {
    setState(() {
      lightOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turn on the light"),
      ),
      body: GestureDetector(
        onPanStart: (val) => _onPanUpdate(val.localPosition),
        onPanUpdate: (val) => _onPanUpdate(val.localPosition),
        onPanEnd: _onPanEnd,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: FlutterLogo(
                size: MediaQuery.of(context).size.width,
                style: FlutterLogoStyle.horizontal,
              ),
            ),
            ClipPath(
              clipper: lightOn ? LightClipper(x, y, radius: radius) : null,
              child: Container(
                color: Colors.black,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Touch the screen to turn on the light",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LightClipper extends CustomClipper<Path> {
  final double x, y;
  final radius;
  LightClipper(this.x, this.y, {this.radius = 50.0});

  @override
  Path getClip(Size size) {
    final circlePath = Path()
      ..addOval(Rect.fromCircle(center: Offset(x, y), radius: radius));
    final fullPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    return Path.combine(PathOperation.reverseDifference, circlePath, fullPath);
  }

  @override
  bool shouldReclip(LightClipper oldClipper) =>
      x != oldClipper.x || y != oldClipper.y;
}
