import 'package:flutter/material.dart';
import 'package:truthormare/widgets/main_game/dare_popup.dart';
import '../../models/card.dart';
import 'package:truthormare/models/player.dart';

class AnswerRow extends StatelessWidget {
  final Function finishTurn;

  const AnswerRow(
    this.finishTurn, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (ctx) {
                  return DarePopup(finishTurn);
                });
          },
          icon: const Icon(Icons.cancel, size: 50),
        ),
        IconButton(
          onPressed: () {
            finishTurn(scoreAdjustment.truth);
          },
          icon: const Icon(
            Icons.check_circle,
            size: 50,
          ),
        ),
      ],
    );
  }
}
