import 'package:vector_math/vector_math_64.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:truthormare/providers/game.dart';

class MiniHorseShoe extends StatefulWidget {
  final int index;
  final double shoeWidth;
  final double radius;
  final bool isVisible = true;
  final int itemCount;
  late Image image = Image.asset(
    "assets/images/round/minihorseshoe.png",
    width: shoeWidth,
  );
  final double randomSeed = math.Random().nextDouble() * 2;

  late double angle = index * math.pi * 2 / itemCount;

  MiniHorseShoe({ required this.index, required this.radius, required this.itemCount, required this.shoeWidth});

  // ignore: use_key_in_widget_constructors

  MiniHorseShoeState createState() => MiniHorseShoeState();
}

class MiniHorseShoeState extends State<MiniHorseShoe>
    with SingleTickerProviderStateMixin {
  late AnimationController swingController;
  late Animation swingAnimation;
  @override
  void initState() {
    swingController = AnimationController(
        vsync: this,
        duration:
            Duration(milliseconds: 2000 + (widget.randomSeed * 100).round()));
    swingAnimation = Tween(
            begin: -1 - widget.randomSeed, end: 1 + widget.randomSeed)
        .animate(
            CurvedAnimation(parent: swingController, curve: Curves.bounceOut));

    swingController.addListener(() {
      if (swingController.isCompleted) {
        swingController.repeat(reverse: true);
      }
    });

    swingController.forward();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    swingController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    GameProvider gameLogic = Provider.of<GameProvider>(context);

    return AnimatedBuilder(
        animation: swingController,
        builder: (context, child) => Transform(
              transform: Matrix4.translation(Vector3(
                  math.sin(widget.angle) * widget.radius,
                  math.cos(widget.angle) * widget.radius,
                  0.0))
                ..rotateZ(swingAnimation.value),
              alignment: FractionalOffset.center,
              child: widget.image,
            ));
  }
}
