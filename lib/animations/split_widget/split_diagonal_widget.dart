import 'package:flutter/material.dart';

class SplitDiagonalWidget extends StatefulWidget {
  final Widget child;

  const SplitDiagonalWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _SplitDiagonalWidgetState createState() => _SplitDiagonalWidgetState();
}

class _SplitDiagonalWidgetState extends State<SplitDiagonalWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double? _childHeight;
  GlobalKey _childKey = GlobalKey();

  Widget _buildSide({bool top = true}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0.0, !top ? 1 : -1) * _animation.value / 2,
        child: child,
      ),
      child: ClipPath(
        child: widget.child,
        clipper: SplitClipper(top: top),
      ),
    );
  }

  void _onLayoutDone(_) {
    _childHeight = _childKey.currentContext!.size!.height;
    _animation = Tween<double>(
      begin: 0.0,
      end: _childHeight! * 0.5,
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
      key: _childKey,
      child: Center(
        child: SizedBox(
          height: _childHeight != null ? _childHeight : 0.0,
          width: MediaQuery.of(context).size.width,
          child: _childHeight != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildSide(),
                    _buildSide(top: false),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class SplitClipper extends CustomClipper<Path> {
  final bool top;

  SplitClipper({this.top = false});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0.0, size.height * 0.75);
    path.lineTo(size.width, size.height * 0.25);
    if (!top) {
      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
    } else {
      path.lineTo(size.width, 0.0);
      path.lineTo(0.0, 0.0);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
