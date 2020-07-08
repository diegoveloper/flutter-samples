import 'dart:math';

import 'package:flutter/material.dart';

class CustomSliverHeader extends StatefulWidget {
  @override
  CustomSliverHeaderState createState() {
    return CustomSliverHeaderState();
  }
}

const avatarSize = 60.0;
const minAvatarSize = 30.0;
const extraSpace = 70.0;

class CustomSliverHeaderState extends State<CustomSliverHeader> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Material(
        color: Color(0XFF181818),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  delegate: MyHeaderDelegate(
                      kToolbarHeight + avatarSize + extraSpace),
                  pinned: true,
                ),
              ];
            },
            body: ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text("Item $index"),
              ),
              itemCount: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double extendedHeight;

  MyHeaderDelegate(this.extendedHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print("shrinkOffset: $shrinkOffset ... $overlapsContent");
    double newSize = maxExtent - shrinkOffset;
    double newSizePercent = avatarSize + extraSpace - shrinkOffset;
    double newAvatarSize = avatarSize - shrinkOffset;
    double newAvatarSpace = avatarSize - shrinkOffset;
    if (newSize < minExtent) {
      newSize = minExtent;
    }
    if (newAvatarSize < minAvatarSize) {
      newAvatarSize = minAvatarSize;
    }
    if (newAvatarSpace < 0) {
      newAvatarSpace = 0;
    }
    final percent = (newSizePercent >= 0 ? newSizePercent : 0) /
        (avatarSize + extraSpace).abs();
    double avatarXPosition = max(
        ((MediaQuery.of(context).size.width / 2) - newAvatarSize / 2) * percent,
        15);

    double actionsXPosition = 50 * (1 - percent);

    return Container(
      color: Color(0xFF2C2E2F),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: kToolbarHeight + newAvatarSpace,
            child: Stack(
              children: [
                AppBar(
                  title: Text("Google"),
                  centerTitle: false,
                  elevation: 0.0,
                  actions: [
                    Container(
                      width: 150,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 0,
                            right: actionsXPosition,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.help),
                                  onPressed: () => null,
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () => null,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  bottom: minAvatarSize / 2,
                  right: avatarXPosition,
                  child: CircleAvatar(
                    radius: newAvatarSize / 2,
                    backgroundColor: Colors.red,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Opacity(
              opacity: percent,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                    child: Text("Full Name",
                        style: Theme.of(context).textTheme.headline4)),
                Expanded(
                  child: Text("email@email.com",
                      style: Theme.of(context).textTheme.headline6),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => extendedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
