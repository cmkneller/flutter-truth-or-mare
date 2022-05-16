import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/widgets/player_setup/player_slider.dart';
import '../../models/avatar.dart';
import '../../providers/players.dart';
import '../welcome/animated_welcome_button.dart';
import './player_avatar.dart';
import 'package:truthormare/models/player.dart';

class AddPlayerWidget extends StatefulWidget {
  const AddPlayerWidget({Key? key}) : super(key: key);

  @override
  _AddPlayerWidgetState createState() => _AddPlayerWidgetState();
}

class _AddPlayerWidgetState extends State<AddPlayerWidget>
    with TickerProviderStateMixin {
  final playerNameTextController = TextEditingController();
  late AnimationController _cloudController;
  late AnimationController _signController;
  late Animation _cloudAnimation;
  late Animation _signAnimation;

  @override
  void initState() {
    _signController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _cloudController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    _cloudAnimation = Tween(begin: -1.0, end: 1.0).animate(_cloudController);
    _signAnimation = Tween(begin: 1.0, end: 1.05).animate(_signController);

    _cloudController.addListener(() {
      if (_cloudController.isCompleted) {
        _cloudController.repeat(reverse: true);
      }
    });
    _signController.addListener(() {
      if (_signController.isCompleted) {
        _signController.repeat(reverse: true);
      }
    });
    _cloudController.forward();
    _signController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _cloudController.dispose();
    playerNameTextController.dispose();
    super.dispose();
  }

  bool _isValidated() {
    if (playerNameTextController.text.length > 1 ) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    PlayersProvider playersProvider = Provider.of<PlayersProvider>(context);
    List<Avatar> playerAvatars = playersProvider.playerAvatars;
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: _deviceHeight * 0.55,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(102, 171, 221, 1),
            Color.fromRGBO(164, 206, 229, 1)
          ],
        ),
      ),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Positioned(
            child: Image.asset(
          "assets/images/player/backgroundPlate.png",
        )),
        AnimatedBuilder(
            animation: _cloudAnimation,
            builder: (context, child) => Positioned(
                top: 20,
                right: 0,
                width: _deviceWidth * 0.5,
                child: Transform.translate(
                    offset: Offset(_cloudAnimation.value * 25, 0),
                    child: Image.asset("assets/images/player/cloud1.png")))),
        AnimatedBuilder(
            animation: _cloudAnimation,
            builder: (context, child) => Positioned(
                top: 100,
                left: 0,
                width: _deviceWidth * 0.3,
                child: Transform.translate(
                    offset: Offset(_cloudAnimation.value * 10, 0),
                    child: Image.asset("assets/images/player/cloud2.png")))),
        Positioned(
            width: _deviceWidth * 1.09,
            child: Image.asset(
              "assets/images/player/midgroundPlate.png",
            )),

        Positioned(
          bottom: 0,
          child: PlayerSlider(playerAvatars)),    
        Positioned(
            width: _deviceWidth * 1.09,
            child: IgnorePointer(
              child: Image.asset(
                "assets/images/player/foregroundPlate.png",
              ),
            )),
        AnimatedBuilder(
          animation: _signAnimation,
          builder: (context, child) => Positioned(
              bottom: _deviceWidth * 0.185,
              width: _deviceWidth * 0.32,
              child: Transform.scale(
                  scale: _signAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/images/player/sign.png",
                width: 120,
                      ),
                      Positioned(
                        bottom: 39,
                        width: 110,
                        child: TextField(
                          controller: playerNameTextController,
                          onChanged: (value) => {setState(() => {})},
                        textCapitalization: TextCapitalization.characters,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                        autofocus: true,
                        decoration: InputDecoration.collapsed(hintText: ""),
                        textAlign: TextAlign.center,
                          maxLines: 1,
                          inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        ),
                      ),
                    ],
                  ))),
        ),
        Positioned(
            top: ((_deviceHeight * 0.5) / 2),
            width: _deviceWidth * 0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlossyButton(Icon(Icons.arrow_back), () {}, 28),
                GlossyButton(Icon(Icons.arrow_forward), () {}, 28),
              ],
            )),
        if(_isValidated ()) GlossyButton(Icon(Icons.add), () {}, 28)
      ]),
    );
   
  }
}
