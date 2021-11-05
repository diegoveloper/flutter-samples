import 'package:flutter/material.dart';

class ContentNavigation extends StatelessWidget {
  final Color? color;

  const ContentNavigation({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1 / 1.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 15,
      padding: const EdgeInsets.all(15),
      children: [
        ContentItem(
          color: color,
        ),
        ContentItem(
          color: color,
        ),
        ContentItem(
          color: color,
        ),
        ContentItem(
          color: color,
        ),
      ],
    );
  }
}

class ContentItem extends StatelessWidget {
  final Color? color;

  const ContentItem({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color!.withOpacity(0.5),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 7,
              color: color!.withOpacity(0.6),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 7,
              margin: const EdgeInsets.only(right: 10),
              color: color!.withOpacity(0.6),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
