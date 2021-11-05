import 'package:flutter/material.dart';

import 'neon_button.dart';

class NeonButonMain extends StatefulWidget {
  @override
  NeonButonMainState createState() {
    return NeonButonMainState();
  }
}

class NeonButonMainState extends State<NeonButonMain> {
  @override
  Widget build(BuildContext context) {
    const separator = const SizedBox(
      height: 50,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Neon Buttons"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            separator,
            NeonButton(
              text: 'BUTTON SAMPLE BLUE',
              color: Colors.blue,
              onTap: () {
                print('blue pressed');
              },
            ),
            NeonButton(
              text: 'BUTTON SAMPLE RED',
              color: Colors.red,
              onTap: () {
                print('red pressed');
              },
            ),
            NeonButton(
              text: 'BUTTON SAMPLE GREEN',
              color: Colors.green,
              onTap: () {
                print('green pressed');
              },
            ),
            separator,
          ],
        ),
      ),
    );
  }
}
