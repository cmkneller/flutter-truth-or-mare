// Class for animated player slider
// Displays all horses for selection

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/models/avatar.dart';
import 'package:truthormare/providers/players.dart';

class PlayerSlider extends StatefulWidget {
  late List<Image> _playerImages;
  PlayerSlider(List<Avatar> playerAvatars) {
    _playerImages = playerAvatars.map((a) {
      return Image.asset(a.fullImageUrl);
    }).toList();
  }
  @override
  _PlayerSliderState createState() => _PlayerSliderState();
}

class _PlayerSliderState extends State<PlayerSlider> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
        height: deviceWidth,
        width: deviceWidth * 0.22,
        alignment: Alignment.bottomCenter,
        child: Selector<PlayersProvider, int>(
          builder: (context, data, child) {
            return AnimatedSwitcher(
                duration: Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final rotateTween = Tween(begin: -0.05, end: 0.0)
                      .chain(CurveTween(curve: Curves.bounceInOut));
                  final rotateAnimation = animation.drive(rotateTween);

                  return FadeTransition(
                      opacity:
                          animation.drive(CurveTween(curve: Curves.easeInCirc)),
                      child: ScaleTransition(
                        scale: animation,
                        child: RotationTransition(
                          turns: rotateAnimation,
                          child: child,
                        ),
                      ));
                },
                child: Container(
                  key: UniqueKey(),
                  child: widget._playerImages[data],
                ));
          },
          selector: (context, playerProvider) => playerProvider.currAvatar,
        ));
  }
}
