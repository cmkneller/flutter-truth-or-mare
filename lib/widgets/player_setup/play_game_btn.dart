import 'dart:math';

import 'package:flutter/material.dart';

class PlayGameBtn extends StatefulWidget {
  const PlayGameBtn({Key? key}) : super(key: key);

  _PlayGameBtnState createState() => _PlayGameBtnState();
}

class _PlayGameBtnState extends State<PlayGameBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    _animation = Tween(begin: 0.0, end: 1).animate(_animationController);

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.repeat();
      }
    });

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -(sin(_animation.value * 25) * 5)),
            child: Stack(alignment: Alignment.center, children: [
              Transform.rotate(
                angle: -(_animation.value * 180.0),
                child: Image.asset(
                  "assets/images/player/playbtnbackground.png",
                  width: 100,
                ),
              ),
              Image.asset(
                "assets/images/player/playbtnforeground.png",
                width: 100,
              ),
            ]),
          );
        });
  }
}
