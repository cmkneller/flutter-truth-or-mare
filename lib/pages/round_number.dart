import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/widgets/round_setup/horseshoe_spinner.dart';
import 'package:truthormare/widgets/round_setup/round_number.dart';
import 'package:truthormare/widgets/welcome/animated_welcome_button.dart';

class RoundNumber extends StatelessWidget {
  const RoundNumber({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    GameProvider _gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Text(
            "How many rounds do you want to play?",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [HorseshoeSpinner(), RoundNumberText()],
        ),
        Container(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlossyButton(Icon(Icons.arrow_left_sharp), () {
                _gameProvider.decreaseRoundAmount();
              }, 35),
              GlossyButton(Icon(Icons.arrow_right_sharp), () {
                _gameProvider.increaseRoundAmount();
              }, 35),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }
}
