// Round Intro Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/game.dart';

/// Displays to player which round is it
class RoundIntroScreen extends StatefulWidget {
  static const routeName = '/roundintro';
  final changePageCallback;

  RoundIntroScreen(this.changePageCallback, {Key? key}) : super(key: key);

  @override
  State<RoundIntroScreen> createState() => _RoundIntroScreenState();
}

class _RoundIntroScreenState extends State<RoundIntroScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _zoomAnimation;
  late Animation _clipAnimation;
  late Animation _roundTitleAnimation;
  late Animation _roundNumberAnimation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _zoomAnimation = Tween(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Interval(0, 0.25)));

    _clipAnimation = Tween(begin: 3.0, end: 0.95).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.25, 0.50, curve: Curves.bounceInOut)));
    _roundTitleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.50, 0.75, curve: Curves.bounceInOut)));

    _roundNumberAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.75, 1.00, curve: Curves.easeInCirc)));
    _animationController.forward();

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        widget.changePageCallback();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    // Fetches round number from provider.
    gameData.currentStatus = GameStatus.round;
    // Future.delayed(const Duration(milliseconds: 2000), () => {
    //   Navigator.of(context).pushReplacementNamed(gameData.nextRoute)
    // });

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: deviceHeight * 0.15,
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => Transform.scale(
                    scale: _roundTitleAnimation.value,
                    child: child,
                  ),
              child: Text(
                "Round:",
                style: Theme.of(context).textTheme.headline1,
              )),
        ),
  
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => ClipOval(
            clipper: circleClipper(
                Size(deviceWidth, deviceHeight), _clipAnimation.value),
            child: Container(
                height: deviceHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(173, 203, 90, 1),
                        Color.fromARGB(255, 130, 154, 63),
                      ]),
                ),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (ctx, child) => Transform.scale(
                    scale: _zoomAnimation.value,
                    child: Image.asset(
                        "assets/images/round/round-background-panel.png"),
                  ),
                )),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (ctx, child) => Transform.scale(
              scale: _zoomAnimation.value,
              child: Image.asset(
                  "assets/images/round/round-foreground-panel.png")),
        ),
        Positioned(
          top: deviceHeight / 2.2,
          left: deviceWidth * 0.33,
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (ctx, child) =>
                  Opacity(opacity: _roundNumberAnimation.value, child: child),
              child: Text(
                gameData.currentRound.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "atma",
                    decoration: TextDecoration.none,
                    fontSize: 80),
              )),
        )
      ],
    );
  }
}

class circleClipper extends CustomClipper<Rect> {
  final Size deviceSize;
  final double scale;

  circleClipper(this.deviceSize, this.scale);

  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(deviceSize.width / 2, deviceSize.height / 2),
        width: deviceSize.width * scale,
        height: deviceSize.width * scale);
  }

  bool shouldReclip(oldClipper) {
    return true;
  }
}
