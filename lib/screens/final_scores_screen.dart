// Final Scores Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/providers/players.dart';
import '../widgets/final_scores/podium.dart';
import '../models/player.dart';
import 'package:provider/provider.dart';

// Created as statefull, not implemented but will be later for animations.
class FinalScoresScreen extends StatefulWidget {
  static const routeName = '/finalscoresscreen';

  const FinalScoresScreen({Key? key}) : super(key: key);

  @override
  _FinalScoresScreenState createState() => _FinalScoresScreenState();
}

/// Displays a row of [Podium]s of the final scores.
class _FinalScoresScreenState extends State<FinalScoresScreen> {
  @override
  Widget build(BuildContext context) {
    PlayersProvider playerData =
        Provider.of<PlayersProvider>(context, listen: false);
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);

    // Grabs ordered list of players based on scores from playerData provider.
    List<Player> resultList = playerData.topScores;
    gameData.currentStatus = GameStatus.finalScores;

    // Provides functionality to finish game.
    void finishGame() {
      gameData.resetGame();
      playerData.resetPlayers();
      Navigator.of(context).pushReplacementNamed(gameData.nextRoute);
    }

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Final Scores",
            style: TextStyle(fontSize: 25),
          ),
          // Holds podiums of players and their scores
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Podium(2, resultList[1])),
              Expanded(child: Podium(1, resultList[0])),
              if (resultList.length > 2)
                Expanded(child: Podium(3, resultList[2]))
            ],
          ),
          ElevatedButton(onPressed: finishGame, child: const Text("New Game"))
        ],
      )),
    );
  }
}
