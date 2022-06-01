import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:truthormare/screens/player_intro_screen.dart';
import 'package:truthormare/screens/round_intro_screen.dart';

import '../widgets/app_wide/animated_horse_shoe.dart';

class RoundPlayerPageView extends StatefulWidget {
  _RoundPlayerPageViewState createState() => _RoundPlayerPageViewState();
}

class _RoundPlayerPageViewState extends State<RoundPlayerPageView> {
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    final PageController _controller = PageController();

    void changePage() {
      _controller.animateToPage(1,
          duration: Duration(seconds: 1), curve: Curves.easeIn);
    }

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Color.fromARGB(255, 192, 65, 185),
          Color.fromARGB(255, 148, 90, 203),
        ])),
        child: Stack(children: [
          AnimatedHorseShoe(
            top: 0.1,
            right: -0.07,
            width: .50,
            angle: -0.2,
            containerDimensions: {'width': deviceWidth, 'height': deviceHeight},
          ),
          AnimatedHorseShoe(
            bottom: -0.15,
            left: 0,
            width: 1,
            angle: 0.2,
            containerDimensions: {'width': deviceWidth, 'height': deviceHeight},
          ),
          PageView(
            scrollDirection: Axis.vertical,
            controller: _controller,
            children: [RoundIntroScreen(changePage), PlayerIntroScreen()],
          ),
        ]));
  }
}
