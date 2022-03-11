import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/models/player.dart';
import '../../models/card.dart';
import 'package:truthormare/providers/cards.dart';


class DarePopup extends StatelessWidget {
  final Function finishTurn;

  const DarePopup(this.finishTurn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Dare dare = Provider.of<CardsProvider>(context).presentDare;

    return AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text(
          "Dare",
          style: TextStyle(fontSize: 40),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(dare.text),
        Row(
          children: [
            IconButton(
                onPressed: () {
                 finishTurn(scoreAdjustment.cancel);
                },
                icon: const Icon(Icons.cancel)),
            IconButton(
                onPressed: () {
                 finishTurn(scoreAdjustment.dare);
                },
                icon: const Icon(Icons.check_circle)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
      ]),
    );
  }
}
