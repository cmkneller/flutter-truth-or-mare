import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:truthormare/providers/game.dart';

class MiniHorseShoe extends StatefulWidget {
  final _shoeState = _MiniHorseShoeState();
  final int index;
  final double radius;
  final bool isVisible = false;
  final int itemCount;
  // ignore: use_key_in_widget_constructors
  MiniHorseShoe(this.index, this.radius, this.itemCount);

  @override
  State<MiniHorseShoe> createState() => _shoeState;
}

class _MiniHorseShoeState extends State<MiniHorseShoe>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _grow;
  final Image image =
      Image.asset("assets/images/round-number/minihorseshoe.png");
  bool isVisible = false;
  late double angle;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  initState() {
    angle = widget.index * math.pi * 2 / widget.itemCount;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _grow = Tween<double>(begin: 0, end: 1).animate(_controller);
    super.initState();
  }

  Widget build(BuildContext context) {
    GameProvider gameLogic = Provider.of<GameProvider>(context);

    if (gameLogic.roundAmount == widget.index && !isVisible) {
      _controller.forward();
      isVisible = true;
    }

    if (gameLogic.roundAmount + 1 == widget.index && isVisible) {
      _controller.reverse();
      isVisible = false;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Positioned(
        width: 38,
        child: Transform.scale(
          scale: _grow.value,
          child: Transform.translate(
            offset: Offset(math.sin(angle) * widget.radius,
                math.cos(angle) * widget.radius),
            child: image,
          ),
        ),
      ),
    );
  }
}
