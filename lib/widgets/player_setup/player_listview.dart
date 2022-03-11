import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/widgets/player_setup/player_list_tile.dart';
import '../../providers/players.dart';
import '../../models/player.dart';

class PlayerListView extends StatelessWidget {
  const PlayerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayersProvider playerData = Provider.of<PlayersProvider>(context);
    List<Player> playerList = playerData.playerList;

    return Expanded(
      child: ListView.builder(
        itemCount: playerList.length,
        itemBuilder: (ctx, i) => PlayerListTile(playerList[i].id,
            playerList[i].name, playerList[i].avatar, playerData.removePlayer),
      ),
    );
  }
}
