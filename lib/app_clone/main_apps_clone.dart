import 'package:flutter/material.dart';
import 'package:flutter_samples/app_clone/android_messages/android_messages_page.dart';
import 'package:flutter_samples/app_clone/twitter_profile/twitter_profile_page.dart';
import 'package:flutter_samples/main.dart';

class MainAppsClone extends StatefulWidget {
  @override
  MainAppCloneState createState() {
    return new MainAppCloneState();
  }
}

class MainAppCloneState extends State<MainAppsClone> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Apps Clone"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Android Messages Page",
              actionTap: () {
                onButtonTap(AndroidMessagesPage());
              },
            ),
            MyMenuButton(
              title: "Twitter Profile Page",
              actionTap: () {
                onButtonTap(TwitterProfilePage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
