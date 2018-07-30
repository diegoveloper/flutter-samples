import 'package:flutter/material.dart';
import 'package:flutter_samples/hero_animations/main_hero_animations.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(30.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: "hero1",
                child: Container(
                  padding: EdgeInsets.all(40.0),
                  height: 320.0,
                  width: 320.0,
                  child: CustomFlutterLogo(),
                ),
              ),
            ),
            OutlineButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }
}
