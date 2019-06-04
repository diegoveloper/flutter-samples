import 'package:flutter/material.dart';
import 'package:flutter_samples/persistent_tabbar/page1.dart';
import 'package:flutter_samples/persistent_tabbar/page2.dart';

class MainPersistentTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                text: "Non persistent",
              ),
              Tab(icon: Icon(Icons.directions_transit), text: "Persistent"),
              Tab(icon: Icon(Icons.directions_railway), text: "Test 1"),
              Tab(icon: Icon(Icons.directions_subway), text: "Test 2"),
            ],
          ),
          title: Text('Persistent Tab Demo'),
        ),
        body: TabBarView(
          children: [
            Page1(),
            Page2(),
            Text('Page 3'),
            Text('Page 4'),
          ],
        ),
      ),
    );
  }
}
