import 'package:flutter/material.dart';
import '../widgets/app_wide/GlassyBox.dart';
import '../widgets/app_wide/AnimatedTextLogo.dart';
import '../widgets/welcome/animated_welcome_logo.dart';
import '../widgets/welcome/animated_welcome_button.dart';

class intro extends StatelessWidget {
  const intro({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        AnimatedTextLogo(),
        Container(
          height: 0.75 * deviceHeight,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GlassyBox(
                  topPosition: 0.33,
                  height: .335,
                  width: 0.85,
                  padding: 0.15,
                  title: "Don’t Be a Dosey Mare!",
                  content: " Stop horsing around and tell the truth!",
                  callToAction: "Click below to start game!"),
              const AnimatedWelcomeLogo(
                bottom: 0.205,
                width: 1.08,
              ),
              Positioned(
                  bottom: deviceHeight * 0.048, child: AnimatedWelcomeButton()),
            ],
          ),
        )
      ],
    );
  }
}
