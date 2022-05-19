import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/game.dart';
import 'package:truthormare/providers/navigation.dart';
import 'package:truthormare/screens/player_setup_screen.dart';
import 'package:truthormare/widgets/round_setup/horseshoe_spinner.dart';
import 'package:truthormare/widgets/round_setup/round_number.dart';
import 'package:truthormare/widgets/app_wide/glossy_button.dart';

class RoundNumber extends StatelessWidget {
  const RoundNumber({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    GameProvider _gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    NavigationProvider _navProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Text(
            "How many rounds do you want to play?",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [HorseshoeSpinner(), RoundNumberText()],
        ),
        Container(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlossyButton(Icon(Icons.remove), () {
                _gameProvider.decreaseRoundAmount();
              }, 35),
              GlossyButton(Icon(Icons.add), () {
                _gameProvider.increaseRoundAmount();
              }, 35),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 40),
                width: deviceWidth * 0.25,
                child: GlossyButton(Icon(Icons.arrow_back), () {
                  _gameProvider.setRoundAmount(1);
                  _navProvider.setPageID(0);
                }, 30)),
            AddPlayerSign(deviceWidth: deviceWidth),
            Container(
                padding: EdgeInsets.only(bottom: 40),
                width: deviceWidth * 0.25,
                child: GlossyButton(Icon(Icons.brush), () {}, 30)),
          ],
        )
      ],
    );
  }
}

class AddPlayerSign extends StatefulWidget {
  const AddPlayerSign({
    Key? key,
    required this.deviceWidth,
  }) : super(key: key);

  final double deviceWidth;

  @override
  State<AddPlayerSign> createState() => _AddPlayerSignState();
}

class _AddPlayerSignState extends State<AddPlayerSign>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  Duration _duration = Duration(milliseconds: 500);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = Tween(begin: 1.0, end: 1.05).animate(_controller);

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.repeat(reverse: true);
      }
    });

    _controller.forward();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: ((context, child) => Transform.scale(
              alignment: Alignment.bottomCenter,
              scale: _animation.value,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(PlayerSetupScreen.routeName);
                },
                child: Image.asset(
                  "assets/images/round-number/sign.png",
                  width: widget.deviceWidth * 0.50,
                ),
              ),
            )));
  }
}
