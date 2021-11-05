import 'package:flutter/material.dart';

class AndroidMessagesPage extends StatefulWidget {
  @override
  _AndroidMessagesPageState createState() => _AndroidMessagesPageState();
}

class _AndroidMessagesPageState extends State<AndroidMessagesPage> {
  bool isGoingDown = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text("Messages"),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => null,
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => null,
              ),
            ],
          ),
          body: NotificationListener<ScrollNotification>(
              onNotification: (onScrollNotification) {
                if (onScrollNotification is ScrollUpdateNotification) {
                  if (onScrollNotification.scrollDelta! <= 0.0) {
                    if (!isGoingDown) setState(() => isGoingDown = true);
                  } else {
                    if (isGoingDown) setState(() => isGoingDown = false);
                  }
                }
                return false;
              },
              child: _buildList()),
          floatingActionButton: MyFabButton(isGoingDown)),
    );
  }

  _buildList() {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: List.generate(30, (index) => "Message ${index + 1}")
          .map((val) => SMSItem(
                number: "456",
                text: val,
              ))
          .toList(),
    );
  }
}

class MyFabButton extends StatelessWidget {
  final bool isExtended;

  MyFabButton(this.isExtended);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        child: RawMaterialButton(
            elevation: 5.0,
            shape: isExtended
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))
                : CircleBorder(),
            onPressed: () => null,
            fillColor: Colors.blue[600],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: isExtended
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Start chat",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  : const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
            )));
  }
}

class SMSItem extends StatelessWidget {
  final String? number;
  final String? text;

  SMSItem({this.number, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(Icons.person),
            backgroundColor: Colors.redAccent[400],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    number!,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Text(
                    text!,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "Sat",
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
