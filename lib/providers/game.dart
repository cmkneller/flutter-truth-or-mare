// Game provider class
// Author: Chris Kneller
// Date: March 2022
// Version: 1.

import 'package:flutter/material.dart';
import 'package:truthormare/screens/welcome_screen.dart';
import '../models/player.dart';
import '../screens/final_scores_screen.dart';
import '../screens/main_game_screen.dart';
import '../screens/player_intro_screen.dart';
import '../screens/round_intro_screen.dart';

/// Used to keep track of the game status
enum GameStatus { setup, round, playerIntro, mainGame, finalScores }


/// Handles main game logic.
/// 
/// Provides amount of rounds, current rounds and current game mode.
/// Provides funtionality to adjust the round amount
/// and to increment the current round.

class GameProvider with ChangeNotifier {
  int _playersInRound = 0;
  int _turnIdx = 0;
  int _roundAmount = 1;
  int _currentRound = 1;
  bool _gameReady = false;
  final int _maxRounds = 5;
  GameStatus _currentStatus = GameStatus.setup;
  List<Player> _playerList = [];

  /// Checks if the [_roundAmount] is equal to the max,
  /// if not, [_roundAmount] is incremented.
  void increaseRoundAmount() {
    _roundAmount = _roundAmount == _maxRounds ? _maxRounds : _roundAmount + 1;
    notifyListeners();
  }

  /// Checks if the [_roundAmount] is equal to 1,
  /// if not, [_roundAmount] is decreased.
  void decreaseRoundAmount() {
    _roundAmount = _roundAmount == 1 ? 1 : _roundAmount - 1;
    notifyListeners();
  }

  Player get currentPlayer {
    // Returns the current player object.
    return _playerList[_turnIdx];
  }

  int get roundAmount {
    // Returns the amount of rounds set.
    return _roundAmount;
  }

  bool get gameReadyStatus {
    // Returns whether or not the game is ready to start
    return _gameReady;
  }

  int get currentRound {
    // Returns the current round
    return _currentRound;
  }


  void setGameReadyStatus(bool status) {
    _gameReady = status;
  }


  void setPlayers(List<Player> playerList) {
    _playerList = playerList;
    _playersInRound = _playerList.length;
    if (_playersInRound > 1) {
      setGameReadyStatus(true);
    } else {
      setGameReadyStatus(false);
    }
    notifyListeners();
  }

  void incrementRound() {
    //Increments round until it hits the last.
    if (_currentRound != _roundAmount) {
      _currentRound++;
    }
    notifyListeners();
  }

  void incrementTurn() {
    if (_turnIdx == _playersInRound - 1) {
      _turnIdx = 0;
      incrementRound();
    } else {
      _turnIdx++;
    }
    notifyListeners();
  }

  int get turnIndex {
    return _turnIdx;
  }

  bool isFinalRound() {
    // checks if current round is equal to the final round.
    return _currentRound == _roundAmount;
  }

  set currentStatus(GameStatus status) {
    _currentStatus = status;
  }

  String get nextRoute {
    switch (_currentStatus) {
      case (GameStatus.setup):
        return RoundIntroScreen.routeName;

      case (GameStatus.round):
        return PlayerIntroScreen.routeName;

      case (GameStatus.playerIntro):
        return MainGameScreen.routeName;

      case (GameStatus.mainGame):
        if (_currentRound == roundAmount && _turnIdx == _playersInRound - 1) {
          return FinalScoresScreen.routeName;
        }
        if (_turnIdx == _playersInRound - 1) {
          return RoundIntroScreen.routeName;
        }
        return PlayerIntroScreen.routeName;

      case (GameStatus.finalScores):
        return WelcomeScreen.routeName;
    }
    return '/';
  }

  void resetGame() {
    // refreshes everything to as it was at the start.
    _roundAmount = 1;
    _currentRound = 1;
    _playerList = [];
  }
}
