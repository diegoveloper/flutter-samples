import 'package:flutter/material.dart';
import 'package:flutter_samples/communication_widgets/parent_page.dart';

class MainCommunicationWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Communication Widgets"),
        ),
        body: ParentPage(),
      ),
    );
  }
}
