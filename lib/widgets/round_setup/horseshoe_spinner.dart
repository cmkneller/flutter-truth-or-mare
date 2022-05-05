import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/widgets/round_setup/mini_horse_shoe.dart';
import 'package:truthormare/widgets/round_setup/round_number.dart';

class HorseshoeSpinner extends StatefulWidget {
  HorseshoeSpinner({Key? key}) : super(key: key);
  final List<MiniHorseShoe> horseShoeList = [
    MiniHorseShoe(1, 120, 5),
    MiniHorseShoe(2, 120, 5),
    MiniHorseShoe(3, 120, 5),
    MiniHorseShoe(4, 120, 5),
    MiniHorseShoe(5, 120, 5),
  ];

  @override
  State<HorseshoeSpinner> createState() => _horseshoeSpinnerState();
}

class _horseshoeSpinnerState extends State<HorseshoeSpinner>
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
