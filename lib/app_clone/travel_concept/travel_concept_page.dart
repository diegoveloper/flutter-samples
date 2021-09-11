import 'package:flutter/material.dart';
import 'travel_concept_detail_page.dart';
//Design inspiration: https://www.pinterest.es/pin/712624341008795049/

const duration = Duration(milliseconds: 300);

class TravelConceptPage extends StatefulWidget {
  @override
  _TravelConceptPageState createState() => _TravelConceptPageState();
}

const backgroundColor = Color(0xFF8F9CAC);

class _TravelConceptPageState extends State<TravelConceptPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor.withOpacity(0.5),
              backgroundColor,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('TOFIND'),
            actions: [
              IconButton(
                onPressed: () => null,
                icon: Icon(
                  Icons.location_searching,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: locations.length,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  controller: PageController(
                    viewportFraction: 0.7,
                  ),
                  itemBuilder: (_, index) => AnimatedOpacity(
                    duration: duration,
                    opacity: _currentPage == index ? 1.0 : 0.5,
                    child: TravelItem(
                      item: locations[index],
                      itemSelected: _currentPage == index,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '${_currentPage + 1}/${locations.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TravelItem extends StatefulWidget {
  final bool? itemSelected;
  final LocationCard? item;

  const TravelItem({
    Key? key,
    this.itemSelected,
    this.item,
  }) : super(key: key);

  @override
  _TravelItemState createState() => _TravelItemState();
}

class _TravelItemState extends State<TravelItem> {
  bool _selected = false;

  void _onTap() {
    if (_selected) {
      final page = TravelConceptDetailPage(
        location: widget.item,
      );
      Navigator.of(context).push(
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (_, animation1, __) => page,
            transitionsBuilder: (_, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: child,
              );
            }),
      );
    } else {
      setState(() {
        _selected = !_selected;
      });
    }
  }

  void _onVerticalDrag(DragUpdateDetails details) {
    if (details.primaryDelta! > 3.0) {
      setState(() {
        _selected = false;
      });
    }
  }

  Widget _buildStar({bool starSelected = true}) => Expanded(
        child: Icon(
          Icons.star,
          size: 20,
          color: starSelected ? Colors.blueAccent : Colors.grey,
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (!widget.itemSelected!) {
      _selected = false;
    }
    return LayoutBuilder(builder: (context, constraints) {
      final itemHeight =
          constraints.maxHeight * (widget.itemSelected! ? 0.55 : 0.52);
      final itemWidth = constraints.maxWidth * 0.82;

      final borderRadius = BorderRadius.circular(5.0);
      final backWidth = _selected ? itemWidth * 1.2 : itemWidth;
      final backHeight = _selected ? itemHeight * 1.1 : itemHeight;
      return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: _onTap,
          onVerticalDragUpdate: _onVerticalDrag,
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: AnimatedContainer(
                    duration: duration,
                    height: backHeight,
                    width: backWidth,
                    color: Colors.white,
                    margin:
                        EdgeInsets.only(top: _selected ? itemHeight * 0.15 : 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'La Crescenta - Montrose, CA91020',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'NO. 7911847',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    _buildStar(),
                                    _buildStar(),
                                    _buildStar(),
                                    _buildStar(),
                                    _buildStar(
                                      starSelected: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 10.0),
                          child: Row(
                            children: avatars
                                .map(
                                  (f) => Align(
                                    widthFactor: 0.85,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(f),
                                      radius: 15,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: AnimatedContainer(
                    duration: duration,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 5.0),
                          spreadRadius: 5.0,
                        ),
                      ],
                    ),
                    height: itemHeight,
                    width: itemWidth,
                    margin: EdgeInsets.only(
                        bottom: _selected ? itemHeight * 0.5 : 0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: widget.item!.title!,
                            child: Image.network(
                              widget.item!.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.item!.title!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LocationCard {
  final String? title;
  final String? imageUrl;

  LocationCard({this.title, this.imageUrl});
}

List<LocationCard> locations = [
  LocationCard(
    title: 'New York',
    imageUrl:
        'https://image.freepik.com/foto-gratis/skyline-ciudad-nueva-york-centro-manhattan-rascacielos-al-atardecer-ee-uu_56199-56.jpg',
  ),
  LocationCard(
    title: 'San Francisco',
    imageUrl:
        'https://image.freepik.com/foto-gratis/puente-golden-gate-san-francisco_119101-1.jpg',
  ),
  LocationCard(
    title: 'Madrid',
    imageUrl:
        'https://image.freepik.com/foto-gratis/horizonte-ciudad-madrid-dia_119101-27.jpg',
  ),
  LocationCard(
    title: 'Chicago',
    imageUrl:
        'https://image.freepik.com/foto-gratis/horizonte-chicago-ferrocarril_1426-1021.jpg',
  ),
];

final avatars = [
  'https://randomuser.me/api/portraits/thumb/women/10.jpg',
  'https://randomuser.me/api/portraits/thumb/men/1.jpg',
  'https://randomuser.me/api/portraits/thumb/women/5.jpg',
  'https://randomuser.me/api/portraits/thumb/men/10.jpg',
];
