// Class for animated player slider
// Displays all horses for selection

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/models/avatar.dart';
import 'package:truthormare/providers/players.dart';
import 'package:truthormare/utility/constants.dart';


class PlayerSlider extends StatefulWidget {
  late List<Image> _playerImages;
  PlayerSlider(List<Avatar> playerAvatars){
    _playerImages = playerAvatars.map((a){
return Image.asset(a.fullImageUrl);
    }).toList();
  }
  @override
  _PlayerSliderState createState() => _PlayerSliderState();
}

class _PlayerSliderState extends State<PlayerSlider> {
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.width;
    final PlayersProvider playerData = Provider.of<PlayersProvider>(context);
    return Container(
      width: 80,
      height: deviceWidth,
      alignment: Alignment.bottomCenter,
      child: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: widget._playerImages[0],
      )
      
    
    ,
    );
  }
}
