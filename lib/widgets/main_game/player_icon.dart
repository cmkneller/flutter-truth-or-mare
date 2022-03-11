import 'package:flutter/material.dart';

class PlayerIcon extends StatelessWidget {
  final String imageUrl;
  final int userScore;

  const PlayerIcon(this.imageUrl, this.userScore, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imageUrl,
              width: 40,
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.green),
            constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
            child: Text(
              userScore.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        )
      ],
    );
  }
}
