import 'package:flutter/material.dart';

class MyCustomAppBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomSliverDelegate(
                  expandedHeight: 150,
                  title: "My Custom AppBar",
                  description: "SliverPersistentHeader",
                ),
              ),
              SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset("images/characters/goku.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final String title;
  final String description;

  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    this.title = "",
    this.description = "",
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final factor = 2 - (expandedHeight / appBarSize);
    final percent = factor < 0 || factor > 1 ? 0.0 : factor;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: Colors.green,
              leading: BackButton(),
              elevation: 0.0,
              title: Opacity(
                opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                child: Text(title),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Card(
                  elevation: 10.0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
