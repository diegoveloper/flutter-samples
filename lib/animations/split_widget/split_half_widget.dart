import 'package:flutter/material.dart';

class SplitHalfWidget extends StatefulWidget {
  final Widget child;

  const SplitHalfWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _SplitHalfWidgetState createState() => _SplitHalfWidgetState();
}

class _SplitHalfWidgetState extends State<SplitHalfWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double? _childWidth;
  GlobalKey _childKey = GlobalKey();

  Widget _buildSide({bool left = true}) {
    return _childWidth != null
        ? AnimatedBuilder(
            animation: _animation,
            builder: (_, child) => SizedBox(
              width: _childWidth,
              child: Transform.translate(
                offset: Offset((left ? 1 : -1) * _animation.value / 2, 0.0),
                child: child,
              ),
            ),
            child: ClipPath(
              child: widget.child,
              clipper: SplitClipper(left: left),
            ),
          )
        : SizedBox.shrink();
  }

  void _onLayoutDone(_) {
    _childWidth = _childKey.currentContext!.size!.width / 2;
    _animation = Tween<double>(
      begin: _childWidth,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);
    super.initState();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0).whenComplete(() => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation,
      child: Row(
        key: _childKey,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSide(),
          _buildSide(left: false),
        ],
      ),
    );
  }
}

class SplitClipper extends CustomClipper<Path> {
  final bool left;

  SplitClipper({this.left = false});

  @override
  Path getClip(Size size) {
    Path path = Path();
    if (!left) {
      path.addRect(
          Rect.fromLTWH(size.width / 2, 0.0, size.width / 2, size.height));
    } else {
      path.addRect(Rect.fromLTWH(0.0, 0.0, size.width / 2, size.height));
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
