

import 'package:flutter/material.dart';


class AnimatedWelcomeLogo extends StatelessWidget {
  const AnimatedWelcomeLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Image.asset(
        'assets/images/welcome-screen/w-splash.png',
        width: 300,
      ),
    );
  }
}