// Player Intro Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/models/player.dart';
import 'package:truthormare/providers/game.dart';

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
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);
    gameData.currentStatus = GameStatus.playerIntro;
    Player currentPlayer = gameData.currentPlayer;

    void nextStep() {
      Navigator.of(context).pushReplacementNamed(gameData.nextRoute);
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.asset(
                currentPlayer.avatar.fullImageUrl,
                width: 200,
              ),
              radius: 150,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              currentPlayer.name,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: nextStep, child: const Text("Ready"))
          ],
        ),
      ),
    );
  }
}
