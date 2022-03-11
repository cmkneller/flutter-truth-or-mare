import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/game.dart';

class StartGameButton extends StatelessWidget {
  const StartGameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameData = Provider.of<GameProvider>(context);
    return gameData.gameReadyStatus
        ? FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(gameData.nextRoute);
            },
            label: const Text("Start Game"))
        : Container();
  }
}
