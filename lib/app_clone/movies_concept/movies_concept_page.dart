import 'dart:ui';

import 'package:flutter/material.dart';

class Movie {
  final String? url;
  final String? title;

  const Movie({this.url, this.title});
}

const movies = [
  const Movie(
      url: 'https://i.ytimg.com/vi/YcHKrNMwWyQ/movieposter.jpg', title: 'Dora'),
  const Movie(
      url:
          'https://cdn.shopify.com/s/files/1/0057/3728/3618/products/5cae019e64c0ee10ead36a00e60f0137_eeb2d749-fdbe-46fd-978a-870cc7e0ddf7_500x.jpg?v=1573593942',
      title: 'Joker'),
  const Movie(
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRAog3B6UEzMDOhehRXmjQbV2qYGOHYMh3jGGwqL7zwnwRJ6YyD',
      title: 'Predator'),
  const Movie(
    url:
        'https://images-na.ssl-images-amazon.com/images/I/719fSnntGgL._AC_SL1500_.jpg',
    title: 'Anabelle',
  ),
];

class MoviesConceptPage extends StatefulWidget {
  @override
  _MoviesConceptPageState createState() => _MoviesConceptPageState();
}

class _MoviesConceptPageState extends State<MoviesConceptPage> {
  final pageController = PageController(viewportFraction: 0.7);
  final ValueNotifier<double?> _pageNotifier = ValueNotifier(0.0);

  void _listener() {
    _pageNotifier.value = pageController.page;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(_listener);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ValueListenableBuilder<double?>(
                valueListenable: _pageNotifier,
                builder: (context, value, child) {
                  return Stack(
                    children: movies.reversed
                        .toList()
                        .asMap()
                        .entries
                        .map(
                          (entry) => Positioned.fill(
                            child: ClipRect(
                              clipper: MyClipper(
                                percentage: value,
                                title: entry.value.title,
                                index: entry.key,
                              ),
                              child: Image.network(
                                entry.value.url!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height / 3,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white60,
                  Colors.white24,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
            ),
          ),
          PageView.builder(
              itemCount: movies.length,
              controller: pageController,
              itemBuilder: (context, index) {
                final lerp =
                    lerpDouble(0, 1, (index - _pageNotifier.value!).abs())!;

                double opacity =
                    lerpDouble(0.0, 0.5, (index - _pageNotifier.value!).abs())!;
                if (opacity > 1.0) opacity = 1.0;
                if (opacity < 0.0) opacity = 0.0;
                return Transform.translate(
                  offset: Offset(0.0, lerp * 50),
                  child: Opacity(
                    opacity: (1 - opacity),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        color: Colors.white,
                        borderOnForeground: true,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          height: size.height / 1.5,
                          width: size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 23.0, left: 23.0, right: 23.0),
                                  child: ClipRRect(
                                    borderRadius: borderRadius,
                                    child: Image.network(
                                      movies[index].url!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    movies[index].title!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          Positioned(
            left: size.width / 4,
            bottom: 20,
            width: size.width / 2,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Text(
                  'BUY TICKET',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => null),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(5, 5),
                      blurRadius: 20,
                      spreadRadius: 5),
                ],
              ),
              child: BackButton(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final double? percentage;
  final String? title;
  final int? index;

  MyClipper({
    this.percentage = 0.0,
    this.title,
    this.index,
  });

  @override
  Rect getClip(Size size) {
    int currentIndex = movies.length - 1 - index!;
    final realPercent = (currentIndex - percentage!).abs();
    if (currentIndex == percentage!.truncate()) {
      return Rect.fromLTWH(
          0.0, 0.0, size.width * (1 - realPercent), size.height);
    }
    if (percentage!.truncate() > currentIndex) {
      return Rect.fromLTWH(0.0, 0.0, 0.0, size.height);
    }
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
