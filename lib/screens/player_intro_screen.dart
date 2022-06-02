// Player Intro Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/models/player.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/widgets/round_setup/horseshoe_spinner.dart';

// Created statefull to implement animations later.
class PlayerIntroScreen extends StatefulWidget {
  static const routeName = '/playerintroscreen';

  const PlayerIntroScreen({Key? key}) : super(key: key);

  @override
  _PlayerIntroScreenState createState() => _PlayerIntroScreenState();
}

/// Displays the name and avatar of the [Player] who's turn it is.
class _PlayerIntroScreenState extends State<PlayerIntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _horseAnimation;
  late Animation _horseShoeAnimation;
  late Animation _nameAnimation;
  late Animation _buttonAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _horseAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.33,
          curve: Curves.bounceInOut,
        )));

    _horseShoeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.25,
          0.50,
        )));

    _nameAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.75, curve: Curves.bounceOut)));

    _buttonAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.75, 1.00, curve: Curves.easeInCirc)));

    _animationController.forward();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    GameProvider gameData = Provider.of<GameProvider>(context, listen: false);
    gameData.currentStatus = GameStatus.playerIntro;
    Player currentPlayer = gameData.currentPlayer;
    String playerName;

    if (currentPlayer.name.toLowerCase().endsWith("s")) {
      playerName = currentPlayer.name + "'";
    } else {
      playerName = currentPlayer.name + "'s";
    }

    void nextStep() {
      Navigator.of(context).pushReplacementNamed(gameData.nextRoute);
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (ctx, child) => Opacity(
                  opacity: _horseShoeAnimation.value,
                  child: child,
                ),
                child: HorseshoeSpinner(
                  isRoundNumber: false,
                  radius: deviceWidth * 0.8 / 2,
                  amount: 10,
                  shoeWidth: 35,
                ),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (ctx, child) => Transform.scale(
                  scale: _horseAnimation.value,
                  child: child,
                ),
                child: Image.asset(
                  currentPlayer.avatar.fullImageUrl,
                  width: deviceWidth * 0.2,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (ctx, child) => Transform.scale(
              scale: _nameAnimation.value,
              child: child,
            ),
            child: Text(
              playerName + " turn",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AnimatedBuilder(
              animation: _animationController,
              builder: ((cxt, child) => Opacity(
                    opacity: _buttonAnimation.value,
                    child: child,
                  )),
              child: ElevatedButton(
                  onPressed: nextStep, child: const Text("Ready")))
        ],
      ),
    );
  }
}
