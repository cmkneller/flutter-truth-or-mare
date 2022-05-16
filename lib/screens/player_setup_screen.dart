// Player Setup Screen class
// Author: Chris Kneller
// Date May 2022
// Version 2

import 'package:flutter/material.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/widgets/player_setup/start_game_button.dart';
import '../widgets/player_setup/add_player_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/player_setup/player_listview.dart';

/// Allows [Player]s to choose their [Avatar] and name, also displays a list
/// of current players
class PlayerSetupScreen extends StatelessWidget {
  static const routeName = '/setupplayer';

  const PlayerSetupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Accesses the gameData provider
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);

    // Letting Game provide know we are in the setup screen
    gameData.currentStatus = GameStatus.setup;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Column(
        children: const [
          AddPlayerWidget(),
          PlayerListView(),
        ],
      ),
      // Only shown when enough players have been added to the game
      floatingActionButton: const StartGameButton(),
    );
  }
}
