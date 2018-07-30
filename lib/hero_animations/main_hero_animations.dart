import 'package:flutter/material.dart';
import 'package:flutter_samples/hero_animations/hero_dialog_route.dart';
import 'package:flutter_samples/hero_animations/page1.dart';
import 'package:flutter_samples/hero_animations/page2.dart';
import 'package:flutter_samples/hero_animations/page3.dart';

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
          transitionDuration: Duration(seconds: 1)),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildCustomButton("Sample 1", Page1()),
                    _buildCustomButton("Sample 2", Page2()),
                    _buildCustomButton("Sample 3", Page3()),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: "hero1",
                    child: ClipOval(
                      child: CustomFlutterLogo(),
                    ),
                  ),
                  Hero(
                      tag: "hero2",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "Sample Hero",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildCustomButton("Sample 4", _buildPopUp(context),
                        isPopup: true),
                    _buildCustomButton("Sample 5", Page1(), isCustom: true)
                  ],
                ),
              ),
            )
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
        color: Colors.grey,
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
            child: Container(
              height: 300.0,
              width: 300.0,
              child: FlutterLogo(),
            ),
          ),
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

class CustomFlutterLogo extends StatelessWidget {
  static const size = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: size,
      height: size,
      child: Center(
        child: FlutterLogo(
          size: size,
        ),
      ),
    );
  }
}
