// Welcome Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/pages/round_number.dart';
import 'package:truthormare/providers/navigation.dart';
import '../providers/game.dart';
import '../pages/intro.dart';

import '../widgets/app_wide/animated_horse_shoe.dart';

// Created statefull to implement animations later.
class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcomescreen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

/// Intro Screen to be displayed to player.
///
class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  bool built = false;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    NavigationProvider pageLogic = Provider.of<NavigationProvider>(context);
    GameProvider gameLogic = Provider.of<GameProvider>(context, listen: false);

    if (built && pageLogic.pageID != _pageController.page?.floor()) {
      _pageController.animateToPage(pageLogic.pageID,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    gameLogic.currentStatus = GameStatus.setup;
    built = true;
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
            top: 0.1,
            right: -0.07,
            width: .50,
            angle: -0.2,
            containerDimensions: {'width': deviceWidth, 'height': deviceHeight},
          ),
          AnimatedHorseShoe(
            bottom: -0.15,
            left: 0,
            width: 1,
            angle: 0.2,
            containerDimensions: {'width': deviceWidth, 'height': deviceHeight},
          ),
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),

            children: [intro(deviceHeight: deviceHeight), RoundNumber()],
          )
        ]),
      ),
    );
  }
}
