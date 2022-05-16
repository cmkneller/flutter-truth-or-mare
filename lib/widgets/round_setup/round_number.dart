import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/game.dart';


class RoundNumberText extends StatelessWidget {
  const RoundNumberText({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    GameProvider gameLogic = Provider.of<GameProvider>(context);
    return Text(
      gameLogic.roundAmount.toString(),
      style: const TextStyle(
          fontSize: 140,
          fontWeight: FontWeight.w900,
          color: Color.fromRGBO(73, 49, 31, 1)),
    );
  }
}
