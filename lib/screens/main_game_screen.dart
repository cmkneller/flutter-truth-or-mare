// Main Game Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/widgets/main_game/player_scores.dart';
import '../models/player.dart';
import '../providers/cards.dart';
import '../providers/game.dart';
import '../widgets/main_game/player_icon.dart';
import '../models/card.dart';
import '../widgets/main_game/truth_card.dart';
import '../widgets/main_game/answer_row.dart';

/// This is the screen where each player is presented with their [Truth]
/// and the option to accept or do a dare

class MainGameScreen extends StatelessWidget {
  static const routeName = '/maingame';

  const MainGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);

    // Sets the current status of the game/
    gameData.currentStatus = GameStatus.mainGame;

    CardsProvider cardsProvider =
        Provider.of<CardsProvider>(context, listen: false);

    Player currentPlayer = gameData.currentPlayer;
    Truth truth = cardsProvider.presentCard;

   /// Called when a player finishes their turn, updates their score on the 
   /// provider and navigates to the next screen. 
    void finishTurn(scoreAdjustment answerType) {
      currentPlayer.adjustScore(answerType);
      Navigator.of(context).pushReplacementNamed(gameData.nextRoute);
      gameData.incrementTurn();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CurrentResultsDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: Builder(
          builder: (context) {
            // Opens a drawer showing the current leaderboard.
            return IconButton(
              icon: const Icon(Icons.star),
              iconSize: 50,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Text("Round: " + gameData.currentRound.toString()),
          PlayerIcon(currentPlayer.avatar.getImageUrl, currentPlayer.score)
        ],
      ),
      body: Column(
        // Displays the truth and answer options in a column.
        children: [TruthCard(truth), AnswerRow(finishTurn)],
      ),
    );
  }
}
