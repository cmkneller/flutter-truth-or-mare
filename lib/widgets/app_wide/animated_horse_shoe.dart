// Animated Horse-Shoe class
// Author: Chris Kneller
// Date: May 2022
// Version 2.

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// [containerDimensions] Dimensions of wrapping container
/// [bottom] % of how far from the bottom
/// [top] % of how far from the top
/// [left] % of how far from the left
/// [width] % of how wide horse-shoe is
/// [angle] angle of rotation
/// [random] seed of randomness to add to translate/rotate animation.

class AnimatedHorseShoe extends StatefulWidget {
  AnimatedHorseShoe({
    required this.containerDimensions,
    this.bottom,
    this.top,
    this.right,
    this.left,
    this.width,
    required this.angle,
    Key? key,
  }) : super(key: key);

  double? top;
  double? width;
  double? left;
  double? right;
  double angle;
  double? bottom;
  final double _random = (math.Random().nextDouble() - 0.5);

  final Map<String, double> containerDimensions;

  @override
  State<AnimatedHorseShoe> createState() => _AnimatedHorseShoeState();
}

class _AnimatedHorseShoeState extends State<AnimatedHorseShoe>
    with SingleTickerProviderStateMixin {
  // Attributes for animation controller and duration
  final Duration _duration = const Duration(seconds: 7);
  late AnimationController _controller;

  @override
  void initState() {
    // Initialising animation controller
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
      reverseDuration: _duration,
    );

    _controller.forward();
    _controller.addListener(() {
      if (_controller.isCompleted) {
        // repeats animation when done, in a yo-yo fashion
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sets up initial positioning based on class attributes.
    // params of positioned elements are only applied if present, otherwise
    // they are listed as null.
    return Positioned(
        top: widget.top != null
            ? widget.top! * widget.containerDimensions['height']!
            : null,
        bottom: widget.bottom != null
            ? -widget.bottom! * -widget.containerDimensions['height']!
            : null,
        right: widget.right != null
            ? widget.right! * widget.containerDimensions['width']!
            : null,
        left: widget.left != null
            ? widget.left! * widget.containerDimensions['width']!
            : null,
        width: widget.width != null
            ? widget.width! * widget.containerDimensions['width']!
            : null,
        // AnimatedBuilder used as child to take advantage of our animation
        // controller
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform(
              transform: Matrix4.translationValues(
                  // values times by _random in order to get some variety
                  math.sin(_controller.value * 0.5) * widget._random,
                  math.cos(_controller.value * 0.5) * widget._random,
                  0)
                ..rotateZ(widget.angle +
                    (math.sin(_controller.value)) * widget._random),
              child: Image.asset('assets/images/welcome-screen/horseshoe.png')),
        ));
  }
}
