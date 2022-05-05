import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/game.dart';

class RoundNumberText extends StatefulWidget {
  const RoundNumberText({Key? key}) : super(key: key);

  @override
  State<RoundNumberText> createState() => _RoundNumberTextState();
}

class _RoundNumberTextState extends State<RoundNumberText> {
  double opacity = 0;

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
