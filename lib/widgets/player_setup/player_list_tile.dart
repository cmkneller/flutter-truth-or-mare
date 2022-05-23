import 'package:flutter/material.dart';
import '../../models/avatar.dart';

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
      child:  Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color.fromRGBO(98, 126, 176, 1),
              //       Color.fromRGBO(63, 79, 108, 1),
              //     ]),
              image: DecorationImage(
                image: AssetImage("assets/images/player/tiletexture.png"),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(200)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  playerAvatar.smallImageUrl,
                  width: 75,
                ),
                Text(
                  playerName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 24),
                ),
                GestureDetector(
                    child: Image.asset(
                  "assets/images/icons/bin.png",
                  width: 65,
                ))
              ],
            ),
          ),
        ),
    );
  }
}
