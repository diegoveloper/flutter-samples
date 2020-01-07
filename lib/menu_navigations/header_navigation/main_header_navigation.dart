import 'package:flutter/material.dart';
import 'package:flutter_samples/menu_navigations/content_navigation.dart';
import 'package:flutter_samples/menu_navigations/header_navigation/header_navigation.dart';

class MainHeaderNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: HeaderNavigation(
          items: [
            HeaderNavigationItem(
              colorBackground: Colors.purple,
              title: "SERVICES",
              colorForeground: Colors.white,
              icon: Icon(
                Icons.room_service,
                size: 45,
              ),
              child: ContentNavigation(
                color: Colors.purple,
              ),
            ),
            HeaderNavigationItem(
              colorBackground: Colors.red,
              title: "AUTO",
              colorForeground: Colors.white,
              icon: Icon(
                Icons.directions_car,
                size: 45,
              ),
              child: ContentNavigation(
                color: Colors.red,
              ),
            ),
            HeaderNavigationItem(
              colorBackground: Colors.green,
              title: "JOB",
              colorForeground: Colors.white,
              icon: Icon(
                Icons.person,
                size: 45,
              ),
              child: ContentNavigation(
                color: Colors.green,
              ),
            ),
            HeaderNavigationItem(
              colorBackground: Colors.blue,
              title: "REALTY",
              colorForeground: Colors.white,
              icon: Icon(
                Icons.home,
                size: 45,
              ),
              child: ContentNavigation(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
