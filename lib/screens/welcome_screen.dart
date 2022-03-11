// Welcome Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game.dart';
import '../widgets/welcome/animated_welcome_logo.dart';
import '../widgets/welcome/animated_welcome_button.dart';

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
    GameProvider gameLogic = Provider.of<GameProvider>(context, listen: false);
    gameLogic.currentStatus = GameStatus.setup;
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            AnimatedWelcomeLogo(),
            SizedBox(
              height: 50,
            ),
            AnimatedWelcomeButton()
          ],
        ),
      ),
    );
  }
}
