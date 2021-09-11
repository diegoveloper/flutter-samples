import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MainSplitImage extends StatefulWidget {
  @override
  _MainSplitImageState createState() => _MainSplitImageState();
}

class _MainSplitImageState extends State<MainSplitImage> {
  ui.Image? _image;
  double _x = 0, _y = 0, _width = 0, _height = 0;

  _loadImage() async {
    final assetImage =
        AssetImage("images/characters/broly.png", bundle: rootBundle);
    final imageKey = await assetImage.obtainKey(ImageConfiguration());
    final DecoderCallback decodeResize = (Uint8List bytes,
        {bool? allowUpscaling, int? cacheWidth, int? cacheHeight}) {
      return ui.instantiateImageCodec(bytes,
          targetHeight: cacheHeight, targetWidth: cacheWidth);
    };
    var load = assetImage.load(imageKey, decodeResize);

    ImageStreamListener listener = ImageStreamListener((info, err) async {
      setState(() {
        _image = info.image;
      });
    });
    load.addListener(listener);
  }

  _reset() {
    setState(() {
      _x = 0;
      _y = 0;
      _width = 0;
      _height = 0;
    });
  }

  _crop() {
    setState(() {
      _x = 120;
      _y = 80;
      _width = 100;
      _height = 100;
    });
  }

  @override
  void initState() {
    _loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Split Image"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reset,
          ),
          IconButton(
            icon: Icon(Icons.crop),
            onPressed: _crop,
          )
        ],
      ),
      body: Center(
        child: CustomPaint(
          child: Container(),
          painter: ImagePainter(
            image: _image,
            x: _x,
            y: _y,
            height: _height,
            width: _width,
          ),
        ),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image? image;
  final double? width;
  final double? height;
  final double? x;
  final double? y;

  ImagePainter({
    this.image,
    this.width,
    this.height,
    this.x,
    this.y,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      if (width != 0 && height != 0 && x != 0 && y != 0) {
        //crop
        canvas.clipRect(Rect.fromLTWH(x!, y!, width!, height!));
      }
      //resize Image
      final ui.Rect rect = ui.Offset.zero & size;
      final Size imageSize =
          Size(image!.width.toDouble(), image!.height.toDouble());
      FittedSizes sizes = applyBoxFit(BoxFit.fitWidth, imageSize, size);
      final Rect inputSubrect =
          Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
      final Rect outputSubrect =
          Alignment.center.inscribe(sizes.destination, rect);

      canvas.drawImageRect(image!, inputSubrect, outputSubrect, Paint());
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
