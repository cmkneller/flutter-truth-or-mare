// Player Intro Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/models/player.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/widgets/round_setup/horseshoe_spinner.dart';

// Created statefull to implement animations later.
class PlayerIntroScreen extends StatefulWidget {
  static const routeName = '/playerintroscreen';

  const PlayerIntroScreen({Key? key}) : super(key: key);

  @override
  _PlayerIntroScreenState createState() => _PlayerIntroScreenState();
}

/// Displays the name and avatar of the [Player] who's turn it is.
class _PlayerIntroScreenState extends State<PlayerIntroScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);
    gameData.currentStatus = GameStatus.playerIntro;
    Player currentPlayer = gameData.currentPlayer;
    String playerName;

    if (currentPlayer.name.toLowerCase().endsWith("s")) {
      playerName = currentPlayer.name + "'";
    } else {
      playerName = currentPlayer.name + "'s";
    }

    void nextStep() {
      Navigator.of(context).pushReplacementNamed(gameData.nextRoute);
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              HorseshoeSpinner(
                isRoundNumber: false,
                radius: deviceWidth * 0.8 / 2,
                amount: 10,
                shoeWidth: 25,
              ),
              Image.asset(
                currentPlayer.avatar.fullImageUrl,
                width: deviceWidth * 0.2,
              )
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Text(
            playerName + " turn",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: nextStep, child: const Text("Ready"))
        ],
      ),
    );
  }
}
