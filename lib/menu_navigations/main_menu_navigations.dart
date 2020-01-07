import 'package:flutter/material.dart';
import 'package:flutter_samples/main.dart';
import 'package:flutter_samples/menu_navigations/header_navigation/main_header_navigation.dart';

class MainMenuNavigations extends StatelessWidget {
  onButtonTap(Widget page, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Menu Navigations"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Header Navigation",
              actionTap: () {
                onButtonTap(MainHeaderNavigation(), context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
