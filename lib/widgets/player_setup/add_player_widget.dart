import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/widgets/player_setup/player_slider.dart';
import '../../models/avatar.dart';
import '../../providers/players.dart';
import '../app_wide/glossy_button.dart';
import './sign_text_field.dart';
import 'add_player_background.dart';

class AddPlayerWidget extends StatelessWidget {
  const AddPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayersProvider playersProvider =
        Provider.of<PlayersProvider>(context, listen: false);
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AddPlayerBackground(deviceWidth: _deviceWidth),
          Positioned(
              width: _deviceWidth * 1.09,
              child: Image.asset(
                "assets/images/player/midgroundPlate.png",
              )),
          Positioned(
              bottom: _deviceWidth * 0.14, child: PlayerSlider(playerAvatars)),
          Positioned(
            width: _deviceWidth * 1.09,
            child: IgnorePointer(
              child: Image.asset(
                "assets/images/player/foregroundPlate.png",
              ),
            ),
          ),
          SignTextField(
            deviceWidth: _deviceWidth,
          ),
          Positioned(
              top: ((_deviceHeight * 0.5) / 2),
              width: _deviceWidth * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlossyButton(Icon(Icons.arrow_back), () {
                    playersProvider.decrementAvatar();
                  }, 28),
                  GlossyButton(Icon(Icons.arrow_forward), () {
                    playersProvider.incrementAvatar();
                  }, 28),
                ],
              )),
        ],
      ),
    );
  }
}
