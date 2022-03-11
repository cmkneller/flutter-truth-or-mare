import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/screens/customise_game_screen.dart';
import 'package:truthormare/screens/player_setup_screen.dart';
import '/providers/game.dart';

class RoundAmountDialog extends StatelessWidget {
  const RoundAmountDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameProvider>(context);
    
    void _addRound() {
      gameData.increaseRoundAmount();
    }

    void _subtractRound() {
      gameData.decreaseRoundAmount();
    }

    void _goToGameCustomiser() {
      Navigator.of(context).pushNamed(CustomiseGameScreen.routName);
    }

    void _setupGame() {
      Navigator.of(context).pushReplacementNamed(PlayerSetupScreen.routeName);
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ],
          ),
          const Text("Rounds:"),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _subtractRound,
                icon: const Icon(Icons.remove_circle),
              ),
              Text(
                gameData.roundAmount.toString(),
                style: const TextStyle(fontSize: 45),
              ),
              IconButton(
                onPressed: _addRound,
                icon: const Icon(Icons.add_circle),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: _goToGameCustomiser,
                    icon: const Icon(
                      Icons.edit,
                      size: 40,
                    ),
                  ),
                  const Text(
                    "Customise",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              IconButton(
                  onPressed: _setupGame,
                  icon: const Icon(
                    Icons.check_circle,
                    size: 40,
                    color: Colors.green,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
