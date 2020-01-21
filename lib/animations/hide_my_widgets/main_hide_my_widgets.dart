import 'package:flutter/material.dart';
import 'package:flutter_samples/animations/hide_my_widgets/hide_my_widget.dart';

class MainHideMyWidgets extends StatefulWidget {
  @override
  _MainHideMyWidgetsState createState() => _MainHideMyWidgetsState();
}

class _MainHideMyWidgetsState extends State<MainHideMyWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Don't touch my widgets!"),
          backgroundColor: Colors.red,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.black,
              child: Image.asset(
                "images/dash_dart_dark.png",
                fit: BoxFit.contain,
              ),
            ),
            HideMyWidget(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0,
                      0.5,
                      1,
                    ],
                    colors: [
                      Color.fromARGB(255, 178, 19, 19),
                      Color.fromARGB(255, 181, 49, 49),
                      Color.fromARGB(255, 89, 10, 10),
                    ],
                  ),
                ),
              ),
            ),
            _myBody(),
          ],
        ));
  }

  Widget _myBody() {
    return Column(
      children: <Widget>[
        Spacer(),
        Expanded(
          flex: 4,
          child: FractionallySizedBox(
            widthFactor: .6,
            child: HideMyWidget(
              child: FlutterLogo(),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: HideMyWidget(
              child: Text(
                "Welcome \nThe Dart Side",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: HideMyWidget(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: HideMyWidget(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
