import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/players.dart';
import 'package:truthormare/widgets/main_game/player_result_listtile.dart';
import '../../models/player.dart';

class CurrentResultsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Player> currentResultList =
        Provider.of<PlayersProvider>(context).topScores;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75),
        child: Column(
          children: [
            Text(
              "Current Results",
              style: TextStyle(fontSize: 30),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: currentResultList.length,
                  itemBuilder: (ctx, i) =>
                      PlayerResultListTile(currentResultList[i], i + 1)),
            )
          ],
        ),
      ),
    );
  }
}
