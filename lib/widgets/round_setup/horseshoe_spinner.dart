import 'package:flutter/material.dart';

import 'package:truthormare/widgets/round_setup/mini_horse_shoe.dart';
import 'package:truthormare/widgets/round_setup/round_number_horse_shoe.dart';

class HorseshoeSpinner extends StatefulWidget {
  final bool isRoundNumber;
  final double radius;
  final double shoeWidth;
  late int amount;
  late List<Widget> horseShoeList = [];
  HorseshoeSpinner(
      {required this.isRoundNumber,
      required this.radius,
      required this.shoeWidth,
      this.amount = 5,
      Key? key})
      : super(key: key) {
    fillOutList();
  }

  void fillOutList() {
    for (int i = 0; i < amount; i++) {
      horseShoeList.add(isRoundNumber
          ? RoundNumberHorseShoe(index:i, radius: radius, itemCount: amount, shoeWidth: shoeWidth,)
          : MiniHorseShoe(index:i, radius: radius, itemCount: amount, shoeWidth: shoeWidth,));
    }
  }

  @override
  State<HorseshoeSpinner> createState() => _HorseshoeSpinnerState();
}

class _HorseshoeSpinnerState extends State<HorseshoeSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _rotationAnimation;
  int currentShoe = 1;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _rotationAnimation =
        Tween<double>(begin: 0, end: 3.14159 * 2).animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.repeat();
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
    // Logic to show shoe:

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.rotate(
          angle: _rotationAnimation.value,
          child: Stack(alignment: Alignment.center, children: [
            ...widget.horseShoeList,
            const SizedBox(
              width: 100,
              height: 100,
            )
          ])),
    );
  }
}
