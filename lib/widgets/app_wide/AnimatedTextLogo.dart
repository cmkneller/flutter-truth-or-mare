import 'package:flutter/material.dart';

class AnimatedTextLogo extends StatefulWidget {
  const AnimatedTextLogo({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedTextLogo> createState() => _AnimatedTextLogoState();
}

class _AnimatedTextLogoState extends State<AnimatedTextLogo>
    with SingleTickerProviderStateMixin {
  final List<String> _imageList = [
    'assets/images/logo/truth_logo.png',
    'assets/images/logo/or_logo.png',
    'assets/images/logo/mare_logo.png'
  ];

  final List<Map<String, dynamic>> _itemList = [];
  final Duration _animationTime = const Duration(milliseconds: 400);
  final Duration _staggerTime = const Duration(milliseconds: 200);

  late final Duration _duration;

  late AnimationController _controller;

  /// Animation functionality:

  @override
  void initState() {
    super.initState();
    _duration = ((_animationTime + _staggerTime) * _imageList.length);
    _controller =
        AnimationController(duration: _duration, vsync: this);
    _filloutList();
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _itemList.map<Widget>((item) {
          return getWidget(item['interval'], item['image'], item['width']);
        }).toList(),
      ),
    );
  }

  Widget getWidget(Interval interval, String image, double width) {
    return Transform.scale(
      scale: Curves.easeInQuad.transform(interval.transform(_controller.value)),
      child: Opacity(
        opacity:
            Curves.easeOut.transform(interval.transform(_controller.value)),
        child: Padding(
          padding: const EdgeInsets.all(2.5),
          child: Image.asset(
            image,
            width: width,
          ),
        ),
      ),
    );
  }

  Interval getInterval(index) {
    final startTime = (_staggerTime * index);
    final endTime = startTime + _animationTime;

    return Interval(
      startTime.inMilliseconds / _duration.inMilliseconds,
      endTime.inMilliseconds / _duration.inMilliseconds,
    );
  }

  void _filloutList() {
    for (int i = 0; i < _imageList.length; i++) {
      Map<String, dynamic> imageMap = {
        "image": _imageList[i],
        "interval": getInterval(i),
        "width": i == 1 ? 35.00 : 100.00
      };
      _itemList.add(imageMap);
    }
  }
}
