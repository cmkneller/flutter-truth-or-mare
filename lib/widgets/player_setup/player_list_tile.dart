import 'package:flutter/material.dart';
import '/models/player.dart';

class PlayerListTile extends StatelessWidget {
  final String playerId;
  final String playerName;
  final Avatar playerAvatar;
  final Function removePlayer;

  const PlayerListTile(
      this.playerId, this.playerName, this.playerAvatar, this.removePlayer,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(playerId),
      onDismissed: (_) => {removePlayer(playerId)},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.asset(playerAvatar.getImageUrl),
            ),
            title: Text(playerName),
          ),
        ),
      ),
    );
  }
}
