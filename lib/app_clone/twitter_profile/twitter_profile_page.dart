import 'package:flutter/material.dart';

class TwitterProfilePage extends StatefulWidget {
  @override
  _TwitterProfilePageState createState() => _TwitterProfilePageState();
}

class _TwitterProfilePageState extends State<TwitterProfilePage> {
  static double avatarMaximumRadius = 40.0;
  static double avatarMinimumRadius = 15.0;
  double avatarRadius = avatarMaximumRadius;
  double expandedHeader = 130.0;
  double translate = -avatarMaximumRadius;
  bool isExpanded = true;
  double offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (scrollNotification) {
            final pixels = scrollNotification.metrics.pixels;

            // check if scroll is vertical ( left to right OR right to left)
            final scrollTabs = (scrollNotification.metrics.axisDirection ==
                    AxisDirection.right ||
                scrollNotification.metrics.axisDirection == AxisDirection.left);

            if (!scrollTabs) {
              // and here prevents animation of avatar when you scroll tabs
              if (expandedHeader - pixels <= kToolbarHeight) {
                if (isExpanded) {
                  translate = 0.0;
                  setState(() {
                    isExpanded = false;
                  });
                }
              } else {
                translate = -avatarMaximumRadius + pixels;
                if (translate > 0) {
                  translate = 0.0;
                }
                if (!isExpanded) {
                  setState(() {
                    isExpanded = true;
                  });
                }
              }

              offset = pixels * 0.4;

              final newSize = (avatarMaximumRadius - offset);

              setState(() {
                if (newSize < avatarMinimumRadius) {
                  avatarRadius = avatarMinimumRadius;
                } else if (newSize > avatarMaximumRadius) {
                  avatarRadius = avatarMaximumRadius;
                } else {
                  avatarRadius = newSize;
                }
              });
            }
            return false;
          },
          child: DefaultTabController(
            length: 8,
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: expandedHeader,
                  backgroundColor: Colors.grey,
                  leading: BackButton(
                    color: isExpanded ? Colors.grey : Colors.white,
                  ),
                  pinned: true,
                  elevation: 5.0,
                  forceElevated: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        color:
                            isExpanded ? Colors.transparent : Colors.blue[800],
                        image: isExpanded
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomCenter,
                                image:
                                    AssetImage("images/twitter_flutter_bg.png"))
                            : null),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: isExpanded
                          ? Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, avatarMaximumRadius),
                              child: MyAvatar(
                                size: avatarRadius,
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            isExpanded
                                ? SizedBox(
                                    height: avatarMinimumRadius * 2,
                                  )
                                : MyAvatar(
                                    size: avatarMinimumRadius,
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  "Following",
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        TwitterHeader(),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: TwitterTabs(50.0),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Tweet();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TwitterTabs extends SliverPersistentHeaderDelegate {
  final double size;

  TwitterTabs(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blueGrey[900],
      height: size,
      child: TabBar(
        isScrollable: true,
        tabs: <Widget>[
          Tab(
            text: "Tweets",
          ),
          Tab(
            text: "Tweets & replies",
          ),
          Tab(
            text: "Media",
          ),
          Tab(
            text: "Likes",
          ),
          Tab(
            text: "Tweets",
          ),
          Tab(
            text: "Tweets & replies",
          ),
          Tab(
            text: "Media",
          ),
          Tab(
            text: "Likes",
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(TwitterTabs oldDelegate) {
    return oldDelegate.size != size;
  }
}

class TwitterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Flutter",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "@flutterio",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Google’s mobile app SDK for building beautiful native apps on iOS and Android in record time // For support visit http://stackoverflow.com/tags/flutter",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          )
        ],
      ),
    );
  }
}

class Tweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(6.0),
      leading: CircleAvatar(
        backgroundImage: AssetImage("images/twitter_flutter_logo.jpg"),
      ),
      title: RichText(
        text: TextSpan(
            text: "Flutter",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
            children: [
              TextSpan(
                  text: "  @flutterio  04 Dec 18",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ]),
      ),
      subtitle: Text(
        "We just announced the general availability of Flutter 1.0 at #FlutterLive! \n\nThank you to all the amazing engineers who made this possible and to our awesome community for their support.",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class MyAvatar extends StatelessWidget {
  final double? size;

  const MyAvatar({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[800]!,
              width: 2.0,
            ),
            shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: size,
            backgroundImage: AssetImage("images/twitter_flutter_logo.jpg"),
          ),
        ),
      ),
    );
  }
}
