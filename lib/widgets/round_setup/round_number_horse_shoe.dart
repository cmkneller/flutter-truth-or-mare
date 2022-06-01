import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/widgets/round_setup/mini_horse_shoe.dart';
import 'dart:math' as math;

import '../../providers/game.dart';

class RoundNumberHorseShoe extends StatefulWidget {
  final bool isVisible = true;
  final int index;
  final double radius;
  final int itemCount;
  final double shoeWidth;
  late MiniHorseShoe horseShoe =
      MiniHorseShoe(index: index, radius: radius, itemCount: itemCount, shoeWidth: shoeWidth,);

  RoundNumberHorseShoe(
      {required this.index,
      required this.radius,
      required this.itemCount,
      required this.shoeWidth,
     Key? key})
      : super(key: key);

  _RoundNumberHorseShowState createState() => _RoundNumberHorseShowState();
}

class _RoundNumberHorseShowState extends State<RoundNumberHorseShoe>
    with SingleTickerProviderStateMixin {
  late Animation _grow;
  late AnimationController _controller;
  bool isVisible = false;
  @override
  initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _grow = Tween<double>(begin: 0, end: 1).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    GameProvider gameLogic = Provider.of<GameProvider>(context);

    if (gameLogic.roundAmount == widget.index + 1 && !isVisible) {
      _controller.forward();
      isVisible = true;
    }

    if (gameLogic.roundAmount + 1 == widget.index + 1 && isVisible) {
      _controller.reverse();
      isVisible = false;
    }

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Positioned(
            child:
                Transform.scale(scale: _grow.value, child: widget.horseShoe)));
  }
}
