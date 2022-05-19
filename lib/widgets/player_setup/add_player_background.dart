import 'package:flutter/material.dart';

class AddPlayerBackground extends StatefulWidget {
  const AddPlayerBackground({Key? key, required deviceWidth})
      : _deviceWidth = deviceWidth,
        super(key: key);

  final double _deviceWidth;

  @override
  State<AddPlayerBackground> createState() => _AddPlayerBackgroundState();
}

class _AddPlayerBackgroundState extends State<AddPlayerBackground>
    with SingleTickerProviderStateMixin {
  late Animation _cloudAnimation;
  late AnimationController _cloudController;

  @override
  void initState() {
    _cloudController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _cloudAnimation = Tween(begin: -1.0, end: 1.0).animate(_cloudController);

    _cloudController.addListener(() {
      if (_cloudController.isCompleted) {
        _cloudController.repeat(reverse: true);
      }
    });

    _cloudController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/player/backgroundPlate.png",
        ),
        AnimatedBuilder(
          animation: _cloudAnimation,
          builder: (context, child) => Positioned(
            top: 0,
            right: 0,
            width: widget._deviceWidth * 0.5,
            child: Transform.translate(
              offset: Offset(_cloudAnimation.value * 25, 0),
              child: Image.asset("assets/images/player/cloud1.png"),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _cloudAnimation,
          builder: (context, child) => Positioned(
            top: 50,
            left: 0,
            width: widget._deviceWidth * 0.3,
            child: Transform.translate(
              offset: Offset(_cloudAnimation.value * 10, 0),
              child: Image.asset("assets/images/player/cloud2.png"),
            ),
          ),
        ),
      ],
    );
  }
}
