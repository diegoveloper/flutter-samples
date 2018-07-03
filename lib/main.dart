import 'package:flutter/material.dart';
import 'package:flutter_samples/persistent_tabbar/main_persistent_tabbar.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  _onButtonTap(Widget page) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Flutter Samples"),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              MyMenuButton(
                  title: "Persistent Tab Bar",
                  actionTap: () {
                    _onButtonTap(MainPersistentTabBar());
                  })
            ],
          ),
        ),
      );
  }
}

class MyMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback actionTap;

  MyMenuButton({this.title, this.actionTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50.0,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: new Text(title),
      onPressed: actionTap,
    );
  }
}
