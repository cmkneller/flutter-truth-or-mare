// Welcome Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game.dart';
import '../widgets/app_wide/GlassyBox.dart';
import '../widgets/app_wide/AnimatedTextLogo.dart';
import '../widgets/welcome/animated_welcome_logo.dart';
import '../widgets/welcome/animated_welcome_button.dart';
import '../widgets/app_wide/AnimatedHorseShoe.dart';


// Created statefull to implement animations later.
class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcomescreen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

/// Intro Screen to be displayed to player.
///
/// Currently filled with placeholders, to be filled out in the graphic stage.
class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    GameProvider gameLogic = Provider.of<GameProvider>(context, listen: false);
    gameLogic.currentStatus = GameStatus.setup;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 9, 184, 6),
                Color.fromRGBO(136, 241, 222, 1)
              ]),
        ),
        child: Stack(children: [
        
          AnimatedHorseShoe(
            top: 0.12,
            right: -0.07,
            width: .50,
            angle: -0.2,
            containerDimensions: {
              'width': deviceWidth,
              'height': deviceHeight
            },
          ),
          AnimatedHorseShoe(
            bottom: -0.22,
            left: 0,
            width: 1,
            angle: 0.2,
            containerDimensions: {
              'width': deviceWidth,
              'height': deviceHeight
            },
          ),
          Column(
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
                    AnimatedWelcomeLogo(
                      bottom: 0.205,
                      width: 1.08,
                    ),
                    Positioned(
                        bottom: deviceHeight * 0.048,
                        child: AnimatedWelcomeButton()),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}


