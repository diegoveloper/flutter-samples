import 'package:flutter/material.dart';
import 'package:flutter_samples/app_clone/album_flow/album_flow_page.dart';
import 'package:flutter_samples/app_clone/android_messages/android_messages_page.dart';
import 'package:flutter_samples/app_clone/credit_cards_concept/credit_cards_concept_page.dart';
import 'package:flutter_samples/app_clone/movies_concept/movies_concept_page.dart';
import 'package:flutter_samples/app_clone/photo_concept/photo_concept_page.dart';
import 'package:flutter_samples/app_clone/shoes_store/shoes_store_page.dart';
import 'package:flutter_samples/app_clone/sports_store/sports_store_page.dart';
import 'package:flutter_samples/app_clone/travel_concept/travel_concept_page.dart';
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
            MyMenuButton(
              title: "Movies Concept",
              actionTap: () {
                onButtonTap(MoviesConceptPage());
              },
            ),
            MyMenuButton(
              title: "Photo Concept",
              actionTap: () {
                onButtonTap(PhotoConceptPage());
              },
            ),
            MyMenuButton(
              title: "Sports Store",
              actionTap: () {
                onButtonTap(SportsStorePage());
              },
            ),
            MyMenuButton(
              title: "Shoes Store",
              actionTap: () {
                onButtonTap(ShoesStorePage());
              },
            ),
            MyMenuButton(
              title: "Album Flow",
              actionTap: () {
                onButtonTap(AlbumFlowPage());
              },
            ),
            MyMenuButton(
              title: "Credit Cards Concept",
              actionTap: () {
                onButtonTap(CreditCardConceptPage());
              },
            ),
            MyMenuButton(
              title: "Travel Concept",
              actionTap: () {
                onButtonTap(TravelConceptPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
