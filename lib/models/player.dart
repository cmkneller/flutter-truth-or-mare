import 'package:flutter/material.dart';

import 'avatar.dart';

enum scoreAdjustment { truth, dare, cancel }

class Player with ChangeNotifier {
  // General model for the Player Model, named fields are set in
  // the player-setup-screen

  final String _id;
  final String _playerName;
  int _playerScore = 0;
  final Avatar _avatar;

  Player(this._id, this._playerName, this._avatar);

  String get id {
    return _id;
  }

  String get name {
    return _playerName;
  }

  Avatar get avatar {
    return _avatar;
  }

  int get score {
    return _playerScore;
  }

  void setScore(int newScore) {
    _playerScore = newScore;
  }

  void adjustScore(scoreAdjustment scoreType) {
    int newScore = score;

    switch (scoreType) {
      case scoreAdjustment.truth:
        newScore += 10;
        break;
      case scoreAdjustment.dare:
        newScore += 5;
        break;
      case scoreAdjustment.cancel:
        newScore = newScore <= 0 ? 0 : newScore -= 5;
        break;
      default:
        break;
    }

    setScore(newScore);
  }
}

