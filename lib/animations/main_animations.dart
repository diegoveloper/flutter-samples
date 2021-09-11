import 'package:flutter/material.dart';
import 'package:flutter_samples/animations/circular_list/circular_list_page.dart';
import 'package:flutter_samples/animations/custom_appbar/my_custom_appbar_page.dart';
import 'package:flutter_samples/animations/foldable/foldable_animation.dart';
import 'package:flutter_samples/animations/list_details/list_page.dart';
import 'package:flutter_samples/animations/menu_exploration/main_menu_exploration.dart';
import 'package:flutter_samples/animations/neon_button/neon_button_main.dart';
import 'package:flutter_samples/animations/split_widget/main_split_widget.dart';
import 'package:flutter_samples/animations/turn_on_the_light/turn_on_the_light.dart';
import 'package:flutter_samples/main.dart';

import 'custom_sliverheader/custom_sliver_header.dart';
import 'hide_my_widgets/main_hide_my_widgets.dart';
import 'shrink_top_list/shrink_top_list_page.dart';

class MainAnimations extends StatefulWidget {
  @override
  MainAnimationsState createState() {
    return MainAnimationsState();
  }
}

class MainAnimationsState extends State<MainAnimations> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animations"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Foldable Page",
              actionTap: () {
                onButtonTap(FoldablePage());
              },
            ),
            MyMenuButton(
              title: "List - Detail Page",
              actionTap: () {
                onButtonTap(ListPage());
              },
            ),
            MyMenuButton(
              title: "Circular List Page",
              actionTap: () {
                onButtonTap(CircularListPage());
              },
            ),
            MyMenuButton(
              title: "My Custom AppBar Page",
              actionTap: () {
                onButtonTap(MyCustomAppBarPage());
              },
            ),
            MyMenuButton(
              title: "My Custom Sliver Header",
              actionTap: () {
                onButtonTap(CustomSliverHeader());
              },
            ),
            MyMenuButton(
              title: "Split Widget",
              actionTap: () {
                onButtonTap(MainSplitWidget());
              },
            ),
            MyMenuButton(
              title: "Turn on the light",
              actionTap: () {
                onButtonTap(TurnOnTheLight());
              },
            ),
            MyMenuButton(
              title: "Hide my widgets",
              actionTap: () {
                onButtonTap(MainHideMyWidgets());
              },
            ),
            MyMenuButton(
              title: "Menu Exploration",
              actionTap: () {
                onButtonTap(MainMenuExploration());
              },
            ),
            MyMenuButton(
              title: "Shrink Top List",
              actionTap: () {
                onButtonTap(ShrinkTopListPage());
              },
            ),
            MyMenuButton(
              title: "Neon Buttons",
              actionTap: () {
                onButtonTap(NeonButonMain());
              },
            ),
          ],
        ),
      ),
    );
  }
}
