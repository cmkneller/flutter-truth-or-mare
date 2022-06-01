import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/screens/round_intro_screen.dart';
import 'package:truthormare/widgets/player_setup/play_game_btn.dart';
import 'package:truthormare/widgets/player_setup/player_list_tile.dart';
import '../../providers/players.dart';
import '../../models/player.dart';

class PlayerListView extends StatelessWidget {
  const PlayerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayersProvider playerData = Provider.of<PlayersProvider>(context);
    List<Player> playerList = playerData.playerList;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: deviceHeight * 0.45,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(106, 183, 69, 1),
                Color.fromRGBO(173, 203, 90, 1)
              ])),
          child: ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(106, 183, 69, 1),
                    Colors.transparent,
                    Colors.transparent,
                    Color.fromRGBO(173, 203, 90, 1),
                  ],
                  stops: [
                    0.0,
                    0.1,
                    0.6,
                    0.9
                  ]).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: playerList.length,
                itemBuilder: (ctx, i) => PlayerListTile(
                    playerList[i].id,
                    playerList[i].name,
                    playerList[i].avatar,
                    playerData.removePlayer),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 10,
                ),
              ),
            ),
          ),
        ),
 
      ],
    );
  }
}
