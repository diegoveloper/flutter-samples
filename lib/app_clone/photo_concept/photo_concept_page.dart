import 'package:flutter/material.dart';
import 'photo_detail_page.dart';

const URL_BACKGROUND_IMAGE =
    'https://images.pexels.com/photos/754082/pexels-photo-754082.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const URL_PROFILE_IMAGE =
    'https://images-na.ssl-images-amazon.com/images/I/41-gB7eWQfL._SX324_BO1,204,203,200_.jpg';
const URL_ANIMAL_IMAGES1 = [
  'https://assets.afcdn.com/story/20161017/989289_w980h638c1cx511cy250.jpg',
  'https://www.lavanguardia.com/r/GODO/LV/p6/WebSite/2019/07/21/Recortada/img_lfarras_20190718-134121_imagenes_lv_terceros_istock-942413474-k0CD-U463578544485bEE-992x558@LaVanguardia-Web.jpg',
  'https://www.ambientum.com/wp-content/uploads/2018/10/jaguar-696x464.jpg',
  'https://dam.ngenespanol.com/wp-content/uploads/2020/02/mono-titi-370x260.jpg'
];

const URL_ANIMAL_IMAGES2 = [
  'https://kids.nationalgeographic.com/content/dam/kidsea/kids-core-objects/backgrounds/youareleaving_kids.adapt.768.1.jpg',
  'https://www.iata.org/contentassets/d7c512eb9a704ba2a8056e3186a31921/cargo_live_animals_parrot.jpg?w=330&h=200&mode=crop&scale=both&v=20191213012337',
  'https://r.ddmcdn.com/w_830/s_f/o_1/cx_98/cy_0/cw_640/ch_360/APL/uploads/2015/07/cecil-AP463227356214-1000x400.jpg'
];

const URL_ANIMAL_IMAGES3 = [
  'https://image.shutterstock.com/image-photo/female-bonobo-baby-sitting-on-260nw-1051536416.jpg',
  'https://cdn.mos.cms.futurecdn.net/Z6j2a3pPdyBTQ5iicDe9kn-320-80.jpg',
  'https://images.pexels.com/photos/145939/pexels-photo-145939.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
];

const URL_ANIMAL_IMAGES4 = [
  'https://www.statnews.com/wp-content/uploads/2020/03/GettyImages-630320438-645x645.jpg',
  'https://www.peta.org/wp-content/uploads/2011/02/animal-1851660_1280-e1545083268497-668x336.jpg',
  'https://cdn.pocket-lint.com/r/s/320x/assets/images/145762-apps-feature-bonkers-new-animals-imagined-with-the-power-of-photoshop-image18-2hkgsd40uk-jpg.webp?v1',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/lionel-animals-to-follow-on-instagram-1568319926.jpg?crop=0.922xw:0.738xh;0.0555xw,0.142xh&resize=640:*',
];

const topPercentageBefore = 0.7;
const topPercentageAfter = 0.55;
const itemListWidth = 80.0;

class PhotoConceptPage extends StatefulWidget {
  @override
  _PhotoConceptPageState createState() => _PhotoConceptPageState();
}

class _PhotoConceptPageState extends State<PhotoConceptPage> {
  GlobalKey _keyStack = GlobalKey();
  double _heightStack = 0.0;
  double _heightBackGround = 0.0;
  double _heightImage = 0.0;
  bool expanded = true;

  ScrollController _scrollControllerMain = ScrollController();

  Widget _buildIndicator(String title, int count) => Column(
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 9),
          ),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 24),
          )
        ],
      );

  void _goToDetail(String image, String tag) async {
    final page = PhotoDetailPage(
      image: image,
      tag: tag,
    );
    await Navigator.of(context).push(
      PageRouteBuilder<Null>(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: page,
          );
        },
        transitionDuration: Duration(milliseconds: 700),
      ),
    );
  }

  double _lastOffset = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _heightStack =
            (_keyStack.currentContext!.findRenderObject() as RenderBox)
                .size
                .height;
        _heightBackGround = (_heightStack / 2) + kToolbarHeight;
        _heightImage = (_heightStack - _heightBackGround) * 2;
      });
    });
    _scrollControllerMain.addListener(() {
      bool isGoingLeft = _lastOffset + 10 < _scrollControllerMain.offset;
      bool isGoingRight = _lastOffset - 10 > _scrollControllerMain.offset;

      if (isGoingLeft) {
        if (expanded) {
          setState(() {
            expanded = false;
          });
        }
        _lastOffset = _scrollControllerMain.offset;
      } else if (isGoingRight) {
        if (!expanded) {
          setState(() {
            expanded = true;
          });
        }
        _lastOffset = _scrollControllerMain.offset;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const vSeparator = const SizedBox(height: 5);
    final borderRadius = BorderRadius.circular(20.0);

    double _percentBackground;
    double _currentPercentage;
    if (expanded) {
      _currentPercentage = topPercentageBefore;
      _percentBackground = 1.0;
    } else {
      _currentPercentage = topPercentageAfter;
      _percentBackground = 0.8;
    }
    final topHeight = size.height * _currentPercentage;
    final bottomHeight = size.height * (1 - _currentPercentage);
    const duration = const Duration(milliseconds: 500);
    final imageSize = _heightImage * _percentBackground;
    final backgroundSize = _heightBackGround * _percentBackground;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AnimatedContainer(
            duration: duration,
            height: topHeight,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    key: _keyStack,
                    children: [
                      AnimatedPositioned(
                        duration: duration,
                        child: Image.network(
                          URL_BACKGROUND_IMAGE,
                          fit: BoxFit.cover,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: backgroundSize,
                      ),
                      Positioned(
                        left: 20,
                        top: _heightBackGround / 4,
                        child: Text(
                          'Steve Jobs',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: duration,
                        child: Material(
                          elevation: expanded ? 10 : 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRadius,
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius,
                            child: Image.network(
                              URL_PROFILE_IMAGE,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        top: backgroundSize - imageSize / 2,
                        left: MediaQuery.of(context).size.width / 2 -
                            imageSize / 2,
                        width: imageSize,
                        height: imageSize,
                      ),
                    ],
                  ),
                ),
                AnimatedCrossFade(
                    firstChild: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIndicator('Photos', 184),
                          _buildIndicator('Collections', 15),
                          _buildIndicator('Followers', 400),
                        ],
                      ),
                    ),
                    secondChild: const SizedBox.shrink(),
                    crossFadeState: expanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: duration),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Follow',
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: duration,
            height: bottomHeight,
            child: SingleChildScrollView(
              controller: _scrollControllerMain,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  _buildList(URL_ANIMAL_IMAGES1),
                  vSeparator,
                  _buildList(URL_ANIMAL_IMAGES2),
                  vSeparator,
                  _buildList(URL_ANIMAL_IMAGES3),
                  vSeparator,
                  _buildList(URL_ANIMAL_IMAGES4),
                  vSeparator,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(List<String> images) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 100,
          itemBuilder: (_, index) {
            final image = images[(index % images.length)];
            final tag = '$image$index';
            return Padding(
              padding: const EdgeInsets.all(2.5),
              child: InkWell(
                onTap: () {
                  _goToDetail(image, tag);
                },
                child: Hero(
                  tag: tag,
                  child: Container(
                    width: itemListWidth,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
