import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_samples/app_clone/shoes_store/shoes_store_detail_page.dart';
import 'package:vector_math/vector_math.dart' as vector;

const bottomBackgroundColor = Color(0xFFF1F2F7);
const brands = ['Nike', 'Adidas', 'Jordan', 'Puma', 'Reebok'];
const marginSide = 14.0;
const leftItemSeparator = const SizedBox(
  width: 30,
);

class Shoe {
  final String? name;
  final String? image;
  final double? price;
  final Color? color;

  const Shoe({
    this.name,
    this.image,
    this.price,
    this.color,
  });
}

const shoes = [
  const Shoe(
      name: 'NIKE EPICT-REACT',
      price: 130.00,
      image: 'images/shoes/1.png',
      color: Color(0xFF5574b9)),
  const Shoe(
      name: 'NIKE AIR-MAX',
      price: 130.00,
      image: 'images/shoes/2.png',
      color: Color(0xFF52b8c3)),
  const Shoe(
      name: 'NIKE AIR-270',
      price: 150.00,
      image: 'images/shoes/3.png',
      color: Color(0xFFE3AD9B)),
  const Shoe(
      name: 'NIKE EPICT-REACTII',
      price: 160.00,
      image: 'images/shoes/4.png',
      color: Color(0xFF444547)),
];

const shoesBottom = [
  const Shoe(name: 'NIKE AIR-MAX', price: 170.00, image: 'images/shoes/3.png'),
  const Shoe(
      name: 'NIKE AIR FORCE', price: 130.00, image: 'images/shoes/4.png'),
];

class ShoesStorePage extends StatefulWidget {
  @override
  _ShoesStorePageState createState() => _ShoesStorePageState();
}

class _ShoesStorePageState extends State<ShoesStorePage> {
  final _pageController = PageController(viewportFraction: 0.78);
  final _pageNotifier = ValueNotifier(0.0);

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discover',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              itemBuilder: (_, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Text(
                  brands[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: index == 0 ? Colors.black : Colors.grey[400],
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    Widget _buildBottomItem(Shoe shoe) => Card(
          elevation: 4,
          child: Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, right: 8),
                          child: Icon(Icons.favorite_border),
                        )),
                    Expanded(
                      child: Transform.rotate(
                          angle: vector.radians(18),
                          child: Image.asset(shoe.image!)),
                    ),
                    Text(
                      shoe.name!,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "\$${shoe.price}",
                      style: TextStyle(fontSize: 11),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 4),
                    child: Text(
                      'NEW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  color: Colors.pinkAccent,
                ),
              ),
            ],
          ),
        );

    return Container(
      color: bottomBackgroundColor,
      height: MediaQuery.of(context).size.height * 0.29,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: marginSide),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'More',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                  onPressed: null,
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildBottomItem(shoesBottom.first),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: _buildBottomItem(shoesBottom.last),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() => BottomNavigationBar(
        selectedItemColor: Colors.red,
        backgroundColor: bottomBackgroundColor,
        unselectedItemColor: Colors.grey[400],
        elevation: 4,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.favorite_border,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.location_city,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person_outline,
            ),
          )
        ],
      );

  void _listener() {
    _pageNotifier.value = _pageController.page!;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildLeftItem(String title, bool selected) => Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: selected ? Colors.black : Colors.grey[400],
            fontSize: 14,
          ),
        );
    final size = MediaQuery.of(context).size;
    const marginCenter = EdgeInsets.symmetric(horizontal: 50, vertical: 15);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(marginSide),
            child: _buildHeader(),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLeftItem('New', false),
                          leftItemSeparator,
                          _buildLeftItem('Featured', true),
                          leftItemSeparator,
                          _buildLeftItem('Upcoming', false),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: _buildBottom(context),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: -10,
                  height: size.height * 0.50,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: shoes.length,
                      itemBuilder: (context, index) {
                        final t = (index - _pageNotifier.value);
                        final rotationY = lerpDouble(0, 90, t)!;
                        final translationX = lerpDouble(0, -50, t);
                        final scale = lerpDouble(0, -0.2, t)!;
                        final translationXShoes = lerpDouble(0, 150, t);
                        final rotationShoe = lerpDouble(0, -45, t)!;
                        final transform = Matrix4.identity();
                        transform.translate(translationX);
                        transform.setEntry(3, 2, 0.001);
                        transform.scale(1 - scale);
                        transform.rotateY(vector.radians(rotationY));

                        final transformShoe = Matrix4.identity();
                        transformShoe.translate(translationXShoes);
                        transformShoe.rotateZ(vector.radians(rotationShoe));
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 28.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 800),
                                pageBuilder: (_, animation, __) =>
                                    FadeTransition(
                                  opacity: animation,
                                  child: ShoesStoreDetailPage(
                                    shoe: shoes[index],
                                  ),
                                ),
                              ));
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Transform(
                                  alignment: Alignment.center,
                                  transform: transform,
                                  child: Stack(
                                    children: [
                                      Hero(
                                        tag:
                                            'hero_background_${shoes[index].name}',
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          margin: marginCenter,
                                          color: shoes[index].color,
                                          child: const SizedBox.expand(),
                                        ),
                                      ),
                                      Container(
                                        margin: marginCenter,
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  shoes[index]
                                                      .name!
                                                      .split(' ')
                                                      .join('\n'),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "\$${shoes[index].price}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Spacer(),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: transformShoe,
                                    child: Hero(
                                      tag: 'hero_image_${shoes[index].name}',
                                      child: Image.asset(
                                        shoes[index].image!,
                                        height: size.width / 2.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
