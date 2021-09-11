import 'dart:math';
import 'dart:typed_data';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class HideMyWidget extends StatefulWidget {
  final Widget? child;

  const HideMyWidget({Key? key, this.child}) : super(key: key);

  @override
  _HideMyWidgetState createState() => _HideMyWidgetState();
}

class _HideMyWidgetState extends State<HideMyWidget> with SingleTickerProviderStateMixin {
  bool _hide = false;
  final _key = GlobalKey();
  late AnimationController _animationController;
  OverlayEntry? _entry;

  void _onTap() async {
    RenderRepaintBoundary boundary = _key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final byteData = (await image.toByteData(format: ui.ImageByteFormat.png) as ByteData);
    var pngBytes = byteData.buffer.asUint8List();

    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _entry?.remove();

    final fullHeight = MediaQuery.of(context).size.height;
    final distance = fullHeight - position.dy;
    final min = 10, max = 40;
    final random = min + Random().nextInt(max - min);
    _entry = new OverlayEntry(
      builder: (context) {
        return Positioned(
          top: position.dy + (_animationController.value * distance),
          left: position.dx,
          width: renderBox.size.width,
          height: renderBox.size.height,
          child: Transform(
            transform: Matrix4.identity()..rotateZ(vector.radians(random * _animationController.value)),
            child: Image.memory(pngBytes),
          ),
        );
      },
    );

    Overlay.of(context)!.insert(_entry!);
    await Future.delayed(const Duration(milliseconds: 20));
    setState(() {
      _hide = true;
    });

    final simulation = GravitySimulation(
      position.dy / 10, // acceleration
      0, // starting point
      1, // end point
      0, // starting velocity
    );
    _animationController.animateWith(simulation);
  }

  @override
  void didUpdateWidget(HideMyWidget oldWidget) {
    setState(() {
      _hide = false;
    });
    super.didUpdateWidget(oldWidget);
  }

  void _animationListener() {
    if (_animationController.status == AnimationStatus.completed) {
      _entry!.remove();
      _entry = null;
    } else {
      _entry!.markNeedsBuild();
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
    );
    _animationController.addListener(_animationListener);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeListener(_animationListener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hide ? null : _onTap,
      child: Visibility(
        visible: !_hide,
        child: RepaintBoundary(
          key: _key,
          child: Container(
            child: AbsorbPointer(
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
