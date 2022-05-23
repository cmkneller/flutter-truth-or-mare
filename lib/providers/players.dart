// Players provider class.
// Author: Chris Kneller
// Date: March 2022
// Version: 1.

import 'package:flutter/material.dart';
import '../models/avatar.dart';
import '../models/player.dart';

// List of paths to player avatar images.

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
    for (int i = 0; i < 8; i++) {
      Avatar genAvatar = Avatar(i);
      _avatarList.add(genAvatar);
    }
  }

  /// Accepts [name], generates a [player] instance and calls [_addToList].
  void generatePlayerAddToList(String name) {
    chosenAvatar.setAvailability(false);
    chosenAvatar.avatarSelected(false);

    // Generates a unique id.
    Avatar playerAvatar = Avatar(_chosenAvatarId);
    String id = UniqueKey().toString();
    Player generatedPlayer = Player(id, name, playerAvatar);
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

  void incrementAvatar() {
    if (_chosenAvatarId != _avatarList.length - 1) {
      _chosenAvatarId++;
    } else {
      _chosenAvatarId = 0;
    }

    notifyListeners();
  }

  void decrementAvatar() {
    if (_chosenAvatarId != 0) {
      _chosenAvatarId--;
    } else {
      _chosenAvatarId = 0;
    }

    notifyListeners();
  }

  int get currAvatar {
    return _chosenAvatarId;
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
