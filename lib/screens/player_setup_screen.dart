// Player Setup Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/widgets/player_setup/start_game_button.dart';
import '../widgets/player_setup/player_listview.dart';
import '../widgets/player_setup/add_player_widget.dart';
import 'package:provider/provider.dart';

/// Allows [Player]s to choose their [Avatar] and name, also displays a list
/// of current players
class PlayerSetupScreen extends StatelessWidget {
  static const routeName = '/setupplayer';

  const PlayerSetupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);

    // Letting Game provide know we are in the setup screen
    gameData.currentStatus = GameStatus.setup;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Players"),
      ),
      floatingActionButton: const StartGameButton(),
      body: Column(
        children: const [AddPlayerWidget(), PlayerListView()],
      ),
    );
  }
}
