import 'package:flutter/material.dart';

class AnimatedWelcomeLogo extends StatelessWidget {
  final double bottom;
  final double width;
  const AnimatedWelcomeLogo(
      {required this.bottom, required this.width, Key? key, required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Positioned(
      bottom: deviceHeight * bottom,
      width: deviceHeight * width,
      child: Image.asset(
        'assets/images/welcome-screen/w-splash.png',
        width: double.infinity,
      ),
    );
  }
}
