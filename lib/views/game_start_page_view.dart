import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/players.dart';
import 'package:truthormare/screens/player_setup_screen.dart';
import 'package:truthormare/screens/round_intro_screen.dart';
import 'package:truthormare/views/round_player_pageview.dart';

import '../widgets/player_setup/play_game_btn.dart';

class GameStartPageView extends StatefulWidget {
  static const routeName = '/gamestart';

  _GameStartPageViewState createState() => _GameStartPageViewState();
}

class _GameStartPageViewState extends State<GameStartPageView> {
  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    double deviceHeight = MediaQuery.of(context).size.height;
    PlayersProvider _provider = Provider.of<PlayersProvider>(context);
    return Stack(alignment: Alignment.center, children: [
      PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [PlayerSetupScreen(), RoundPlayerPageView()],
      ),
      if (_provider.playerList.length > 0 && !_provider.playersChosen)
        Positioned(
            child: GestureDetector(
              child: PlayGameBtn(),
              onTap: () {
                _provider.setPlayersChosen(true);
                _controller.animateToPage(1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              },
            ),
            bottom: deviceHeight * 0.05,
            width: 100)
    ]);
  }
}
