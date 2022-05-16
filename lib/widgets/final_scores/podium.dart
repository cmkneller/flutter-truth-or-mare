import 'package:flutter/material.dart';
import '../../models/player.dart';

class Podium extends StatelessWidget {
  final int position;
  final Player player;

 Podium(this.position, this.player);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: Image.asset(player.avatar.smallImageUrl),
        ),
        SizedBox(
          height: 10,
        ),
        Text(player.name),
        SizedBox(
          height: 10,
        ),
         SizedBox(
           height: 200 / position,
           child: Card(    
              child: Center(
                child: Text(
                  position.toString(),
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
         ),
      ],
    );
  }
}
