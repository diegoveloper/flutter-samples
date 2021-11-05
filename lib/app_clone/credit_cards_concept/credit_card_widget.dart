import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_samples/app_clone/credit_cards_concept/credit_card.dart';

class CreditCardWidget extends StatefulWidget {
  final CreditCard? card;
  final bool isDetail;
  final VoidCallback? onTap;

  const CreditCardWidget({
    Key? key,
    this.card,
    this.isDetail = false,
    this.onTap,
  }) : super(key: key);

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget>
    with SingleTickerProviderStateMixin {
  Offset _currentDraggingOffset = Offset.zero;
  double _lastOffsetDy = 0.0;
  late AnimationController _animationController;

  void _onDragEnd(DragEndDetails details) {
    _lastOffsetDy = _currentDraggingOffset.dy;
    final animation = Tween<double>(begin: _lastOffsetDy, end: 0.0)
        .animate(_animationController);
    animation.addListener(() {
      if (mounted) {
        setState(() {
          _lastOffsetDy = animation.value;
          _currentDraggingOffset = Offset(0.0, _lastOffsetDy);
        });
      }
    });
    if (!_animationController.isAnimating)
      _animationController.forward(from: 0.0);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _lastOffsetDy += details.primaryDelta!;
    if (_lastOffsetDy < -180) {
      _lastOffsetDy = -180.0;
    }
    if (_lastOffsetDy > 180) {
      _lastOffsetDy = 180.0;
    }
    setState(() {
      _currentDraggingOffset = Offset(0.0, _lastOffsetDy);
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rotationRequired = !widget.isDetail;
    timeDilation = 1.0;
    return Hero(
      tag: widget.card!.number!,
      flightShuttleBuilder: (
        _,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final Hero toHero = toHeroContext.widget as Hero;
        final Hero fromHero = toHeroContext.widget as Hero;
        return AnimatedBuilder(
          animation: animation,
          child: flightDirection == HeroFlightDirection.push
              ? fromHero.child
              : toHero.child,
          builder: (context, child) {
            double? rotateZ = 0.0;
            final t = Curves.slowMiddle.transform(animation.value);
            if (flightDirection == HeroFlightDirection.push) {
              rotateZ = lerpDouble(-90, 0, t);
            } else {
              rotateZ = lerpDouble(0, 90, t);
            }
            return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..rotateZ((math.pi / 180) * rotateZ!),
              child: child,
            );
          },
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final canAnimate = widget.isDetail &&
              (ModalRoute.of(context)?.animation?.value ?? 0.0) == 1.0;
          final currentAngle = (math.pi / 180) * (_currentDraggingOffset.dy);
          final currentAngleBack =
              (math.pi / 180) * (_currentDraggingOffset.dy + 180);

          final displayBack = (currentAngle < -1.5 || currentAngle > 1.5);
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: widget.onTap,
              onVerticalDragEnd: canAnimate ? _onDragEnd : null,
              onVerticalDragUpdate: canAnimate ? _onDragUpdate : null,
              child: Stack(
                children: [
                  Opacity(
                    opacity: displayBack ? 0.0 : 1.0,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: !canAnimate
                          ? Matrix4.identity()
                          : (Matrix4.identity()
                            ..setEntry(3, 2, 0.002)
                            ..rotateX(
                              currentAngle,
                            )),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              constraints.maxWidth * 0.05),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [
                              0.3,
                              1.0,
                            ],
                            colors: [
                              widget.card!.color!,
                              Colors.grey,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RotatedBox(
                            quarterTurns: rotationRequired ? -1 : 0,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Credit Card',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Icons.wifi,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: widget.isDetail ? 5 : 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'images/credit_cards/chip_logo.png',
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: canAnimate
                                            ? TweenAnimationBuilder<int>(
                                                tween: IntTween(
                                                    begin: 0,
                                                    end: widget
                                                        .card!.number!.length),
                                                duration: const Duration(
                                                    milliseconds: 800),
                                                builder:
                                                    (context, snapshot, _) {
                                                  return Text(
                                                    widget.card!.number!
                                                        .substring(0, snapshot),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                })
                                            : const SizedBox.shrink(),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'CARD HOLDER',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Diegoveloper',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: Text(
                                          'VISA',
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (canAnimate && displayBack)
                    Positioned.fill(
                      child: Transform(
                        alignment: Alignment.center,
                        transform: !canAnimate
                            ? Matrix4.identity()
                            : (Matrix4.identity()
                              ..setEntry(3, 2, 0.002)
                              ..rotateX(
                                currentAngleBack,
                              )),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                constraints.maxWidth * 0.05),
                            color: widget.card!.color,
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              Expanded(
                                child: Container(
                                  color: Colors.black26,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              widget.card!.ccv!,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
