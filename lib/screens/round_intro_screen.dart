// Round Intro Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/game.dart';

/// Displays to player which round is it
class RoundIntroScreen extends StatelessWidget {
  static const routeName = '/roundintro';

  const RoundIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);
    // Fetches round number from provider.
    gameData.currentStatus = GameStatus.round;
    Future.delayed(const Duration(milliseconds: 2000), () => {
      Navigator.of(context).pushReplacementNamed(gameData.nextRoute)
    });

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const  Text("Round:", style: TextStyle(fontSize: 40)),
           const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 150,
              child: Text(
                gameData.currentRound.toString(),
                style:const  TextStyle(fontSize: 80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
