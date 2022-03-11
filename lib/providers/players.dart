// Players provider class.
// Author: Chris Kneller
// Date: March 2022
// Version: 1.

import 'package:flutter/material.dart';
import '../models/player.dart';

// List of paths to player avatar images.
List<String> avatarPaths = [
  "assets/images/app-wide/avatar-1.png",
  "assets/images/app-wide/avatar-2.png",
  "assets/images/app-wide/avatar-3.png",
  "assets/images/app-wide/avatar-4.png",
  "assets/images/app-wide/avatar-5.png",
  "assets/images/app-wide/avatar-6.png",
  "assets/images/app-wide/avatar-7.png",
  "assets/images/app-wide/avatar-8.png",
];

/// Handles Player List Logic.
///
/// Holds list of players as [_playerList], a list of [Avatar]s as [_avatarList].
/// Generates [Player] from user input and adds to [_playerList].
/// Facilitates the removal of [Player]s.
class PlayersProvider with ChangeNotifier {

  List<Player> _playerList = [];
  final List<Avatar> _avatarList = [];
  int _playerAmount = 0;
  int _chosenAvatarId = 0;
  bool _avatarSelected = false;

  PlayersProvider() {
  // List of avatars generated inside constructor.
    _fillOutAvatars();
  }

  /// Loops through [avatarPaths] and generates a list of [Avatar] instances.
  void _fillOutAvatars() {
    for (int i = 0; i < avatarPaths.length; i++) {
      _avatarList.add(Avatar(i + 1, avatarPaths[i]));
    }
  }

  /// Accepts [name], generates a [player] instance and calls [_addToList].
  void generatePlayerAddToList(String name) {
    chosenAvatar.setAvailability(false);
    chosenAvatar.avatarSelected(false);

    // Generates a unique id.
    String id = UniqueKey().toString();
    Player generatedPlayer = Player(id, name, chosenAvatar);
    _addToList(generatedPlayer);
    _resetAvatars();
  }

 /// Adds [player] to [_playerList] and updates [_playerAmount].
  void _addToList(Player player) {
    _playerList.add(player);
    _playerAmount = _playerList.length;
    notifyListeners();
  }

 /// Removes [Player] from [_playerList] based on [id].
  void removePlayer(id) {
    Player removedPlayer = playerList.firstWhere((player) => player.id == id);
    removedPlayer.avatar.setAvailability(true);
    _playerList = playerList.where((player) => player.id != id).toList();
    _playerAmount = _playerList.length;
    notifyListeners();
  }

  /// Sets an [Avatar] as chosen based on [id]. This is utilised to update
  /// [Avatar] selection UI widget.
  void chooseAvatar(id) {
    _chosenAvatarId = id;
    _avatarSelected = true;
    chosenAvatar.avatarSelected(true);

    for (var avatar in _avatarList) {
      if (avatar.id != chosenAvatar.id) {
        avatar.avatarSelected(false);
      }
    }

    notifyListeners();
  }

  void _resetAvatars() {
    _avatarSelected = false;
    _chosenAvatarId = 0;
  }

  void resetPlayers() {
    for (var avatar in _avatarList) {
      avatar.setAvailability(true);
      avatar.avatarSelected(true);
    }
    _playerList = [];
    _playerAmount = 0;
  }

  /// Returns [Player] selected [Avatar].
  Avatar get chosenAvatar {
    return _avatarList.firstWhere((avatar) => avatar.id == _chosenAvatarId);
  }

  List<Player> get playerList {
    // Returns list of players.
    return _playerList;
  }

  List<Avatar> get playerAvatars {
    // Returns list of player Avatars
    return _avatarList;
  }

  bool get isAvatarSelected {
    // Returns true if an avatar has been selected/
    return _avatarSelected;
  }

  int get playerAmount {
    // Returns amount of players.
    return _playerAmount;
  }

/// Returns a list of [Player]s ordered by score.
  List<Player> get topScores {
    List<Player> sortedList = [..._playerList];
    sortedList.sort((a, b) => b.score.compareTo(a.score));
    return sortedList;
  }
}
