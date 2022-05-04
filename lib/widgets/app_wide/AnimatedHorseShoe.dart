import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedHorseShoe extends StatelessWidget {
  AnimatedHorseShoe({
    required this.containerDimensions,
    this.bottom,
    this.top,
    this.right,
    this.left,
    this.width,
    this.angle,
    Key? key,
  }) : super(key: key);

  double? top;
  double? width;
  double? left;
  double? right;
  double? angle;
  double? bottom;
  final Map <String, double> containerDimensions;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top != null ? top! * containerDimensions['height']! : null,
        bottom: bottom != null ? -bottom! * -containerDimensions['height']! : null,
        right: right != null ? right! * containerDimensions['width']! : null,
        left: left != null ? left! * containerDimensions['width']! : null,
        width: width != null ? width! * containerDimensions['width']! : null,
        child: Transform.rotate(
            angle: angle != null ? math.pi * angle! : 0,
            child: Image.asset('assets/images/welcome-screen/horseshoe.png')));
  }
}