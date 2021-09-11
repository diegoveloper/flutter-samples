import 'package:flutter/material.dart';
import 'dart:math' as math;

class NeonButton extends StatefulWidget {
  final Color color;
  final Color textActiveColor;
  final String text;
  final Duration? duration;
  final VoidCallback? onTap;
  final bool animateAfterChanges;

  const NeonButton({
    Key? key,
    required this.color,
    required this.text,
    this.duration,
    this.onTap,
    this.textActiveColor = Colors.black,
    this.animateAfterChanges = true,
  }) : super(key: key);
  @override
  _NeonButtonState createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  final ValueNotifier<bool> _notifierCompleted = ValueNotifier(false);

  @override
  void didUpdateWidget(NeonButton oldWidget) {
    if (widget.animateAfterChanges) {
      _notifierCompleted.value = false;
      _controller!.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ??
          const Duration(
            milliseconds: 1200,
          ),
    );
    _controller!.forward();
    _controller!.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _notifierCompleted.value = true;
        }
      },
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const padding = 20.0;
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: CustomPaint(
        painter: _NeonLinePainter(
          animation: _controller,
          color: widget.color,
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: _notifierCompleted,
          builder: (context, completed, _) {
            return Material(
              color: completed ? widget.color : Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: completed
                        ? [
                            BoxShadow(
                              blurRadius: padding,
                              spreadRadius: padding,
                              color: widget.color.withOpacity(0.8),
                            ),
                          ]
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: FittedBox(
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              completed ? widget.textActiveColor : widget.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NeonLinePainter extends CustomPainter {
  final Animation? animation;
  final Color? color;

  _NeonLinePainter({
    this.animation,
    this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint paint = Paint()..color = Colors.transparent;
    final progress = animation!.value;
    if (progress > 0.0) {
      paint.color = Colors.black;
      paint.shader = SweepGradient(
        colors: [
          Colors.transparent,
          color!,
          Colors.transparent,
        ],
        stops: [
          0.0,
          1.0,
          1.0,
        ],
        startAngle: math.pi / 8,
        endAngle: math.pi / 2,
        transform: GradientRotation(math.pi * 2 * progress),
      ).createShader(rect);
    }
    final path = Path.combine(
      PathOperation.xor,
      Path()..addRect(rect),
      Path()..addRect(rect.deflate(4.0)),
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_NeonLinePainter oldDelegate) => true;
}
