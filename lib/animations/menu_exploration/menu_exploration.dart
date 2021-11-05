//Design inspired from `Oleg Frolov` https://dribbble.com/shots/6937943-Menu-Interaction-Exploration

import 'package:flutter/material.dart';

const xOffsetContainer = 10.0;

class MenuExploration extends StatefulWidget {
  final List<String> options;
  final double? height;
  final double? width;
  final ValueChanged<String>? onChanged;
  final String? selectedValue;

  MenuExploration({
    Key? key,
    required this.options,
    this.width,
    this.height,
    this.onChanged,
    this.selectedValue,
  })  : assert(options.isNotEmpty),
        super(key: key);

  @override
  _MenuExplorationState createState() => _MenuExplorationState();
}

class _MenuExplorationState extends State<MenuExploration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationContainer;
  PageController? _pageController;
  int _currentIndex = 0;

  void _onTap() {
    _controller.forward(from: 0.0).whenComplete(() => _controller.reverse());
    _pageController!.animateToPage(_currentIndex++,
        duration: const Duration(
          milliseconds: 1100,
        ),
        curve: Curves.elasticOut);
  }

  @override
  void initState() {
    super.initState();
    //In case it has a selected value, find the index and set it as a initial page
    if (widget.selectedValue != null) {
      final index = widget.options.indexWhere(
          (item) => item.toLowerCase() == widget.selectedValue!.toLowerCase());
      if (index >= 0) {
        _currentIndex = index;
      }
    }

    _pageController = PageController(initialPage: _currentIndex);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animationContainer = Tween(
      begin: 0.0,
      end: xOffsetContainer,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInSine,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.0);
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        child: Material(
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            onTap: _onTap,
            child: SizedBox(
              height: widget.height,
              width: widget.width,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => widget.onChanged != null
                    ? widget.onChanged!(widget.options[_getRealIndex(index)])
                    : null,
                itemBuilder: (_, index) {
                  final value = widget.options[_getRealIndex(index)];
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_animationContainer.value, 0.0),
            child: child,
          );
        },
      ),
    );
  }

  int _getRealIndex(int index) => (index >= widget.options.length)
      ? _getRealIndex(index - widget.options.length)
      : index;
}
