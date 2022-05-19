import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/providers/navigation.dart';
import '../widgets/app_wide/GlassyBox.dart';
import '../widgets/app_wide/AnimatedTextLogo.dart';
import '../widgets/welcome/animated_welcome_logo.dart';
import '../widgets/app_wide/glossy_button.dart';

class intro extends StatelessWidget {
  const intro({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    NavigationProvider pageLogic = Provider.of<NavigationProvider>(context, listen: false);
    void startGame() {
      pageLogic.setPageID(1);
    }

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
                  title: "Don’t Be a Dozey Mare!",
                  content: " Stop horsing around and tell the truth!",
                  callToAction: "Click below to start game!"),
              const AnimatedWelcomeLogo(
                bottom: 0.205,
                width: 1.08,
              ),
              Positioned(
                  bottom: deviceHeight * 0.040,
                  child: GlossyButton(
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                    startGame,
                    40,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
