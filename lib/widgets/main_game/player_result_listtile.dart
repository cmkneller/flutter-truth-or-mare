import 'package:flutter/material.dart';
import 'package:truthormare/models/player.dart';

class PlayerResultListTile extends StatelessWidget {
  final Player player;
  final int position;

  PlayerResultListTile(this.player, this.position);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Image.asset(player.avatar.smallImageUrl),
          ),
          title: Text(player.name),
        ),
      ),
    );
  }
}
