import 'package:flutter/material.dart';
import 'package:flutter_samples/hero_animations/hero_dialog_route.dart';
import 'package:flutter_samples/hero_animations/page1.dart';
import 'package:flutter_samples/hero_animations/page2.dart';

class MainHeroAnimationsPage extends StatefulWidget {
  @override
  _MainHeroAnimationsPageState createState() => _MainHeroAnimationsPageState();
}

class _MainHeroAnimationsPageState extends State<MainHeroAnimationsPage> {
  _onButtonTap(Widget page) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true, builder: (BuildContext context) => page));
  }

  _onButtonTapPopup(Widget page) {
    Navigator.push(
        context, HeroDialogRoute(builder: (BuildContext context) => page));
  }

  _onButtonTapCustom(Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder<Null>(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: page,
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 600)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero Animations"),
      ),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        _buildCustomButton("Simple Hero", Page1()),
                        _buildCustomButton("Two Heroes", Page2()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildCustomButton(
                            "Hero on Dialog", _buildPopUp(context),
                            isPopup: true),
                        _buildCustomButton("Custom Hero Animation", Page1(),
                            isCustom: true)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: "hero1",
                    child: ClipOval(
                      child: CustomLogo(
                        size: 60.0,
                      ),
                    ),
                  ),
                  Hero(
                      tag: "hero2",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "Sample Hero",
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCustomButton(String text, Widget page,
      {bool isPopup = false, bool isCustom = false}) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: MaterialButton(
        color: Colors.lightBlue,
        onPressed: () {
          if (isPopup) {
            _onButtonTapPopup(page);
          } else if (isCustom) {
            _onButtonTapCustom(page);
          } else {
            _onButtonTap(page);
          }
        },
        child: Text(text),
      ),
    );
  }

  _buildPopUp(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Hero(
            tag: "hero2", child: Material(child: Text('You are my hero.'))),
        content: Container(
          child: Hero(
              tag: 'hero1',
              child: CustomLogo(
                size: 300.0,
              )),
        ),
        actions: <Widget>[
          OutlineButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class CustomLogo extends StatelessWidget {
  final double size;

  CustomLogo({this.size = 200.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: size,
      height: size,
      child: Center(
        child: Image.asset(
          "images/mario_logo.png",
          width: size,
          height: size,
        ),
      ),
    );
  }
}
