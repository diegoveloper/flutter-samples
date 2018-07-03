import 'package:flutter/material.dart';
import 'package:flutter_samples/persistent_tabbar/page1.dart';
import 'package:flutter_samples/persistent_tabbar/page2.dart';

class MainPersistentTabBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car), text: "Non persistent",),
                Tab(icon: Icon(Icons.directions_transit), text: "Persistent"),
              ],
            ),
            title: Text('Persistent Tab Demo'),
          ),
          body: TabBarView(
            children: [
              Page1(),
              Page2(),
            ],
          ),
        ),
      );
  }
}
