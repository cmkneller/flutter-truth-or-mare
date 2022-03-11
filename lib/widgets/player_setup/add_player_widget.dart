import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/players.dart';
import './player_avatar.dart';
import 'package:truthormare/models/player.dart';

class AddPlayerWidget extends StatefulWidget {
  const AddPlayerWidget({Key? key}) : super(key: key);

  @override
  _AddPlayerWidgetState createState() => _AddPlayerWidgetState();
}

class _AddPlayerWidgetState extends State<AddPlayerWidget> {
  final playerNameTextController = TextEditingController();

  @override
  void dispose() {
    playerNameTextController.dispose();
    super.dispose();
  }

  bool _isValidated(bool avatarSelected) {
    if (playerNameTextController.text.length > 1 && avatarSelected) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    PlayersProvider playersProvider = Provider.of<PlayersProvider>(context);
    List<Avatar> playerAvatars = playersProvider.playerAvatars;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1,
                children: List.generate(
                  playerAvatars.length,
                  (i) => PlayerAvatar(
                      playerAvatars[i], playersProvider.chooseAvatar),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: playerNameTextController,
                    onChanged: (value) => {setState(() => {})},
                    maxLines: 1,
                    inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor:
                      _isValidated(playersProvider.isAvatarSelected)
                          ? Colors.green
                          : const Color.fromRGBO(0, 250, 0, 0.2),
                  child: IconButton(
                    onPressed: () {
                      if (_isValidated(playersProvider.isAvatarSelected)) {
                        playersProvider.generatePlayerAddToList(
                            playerNameTextController.text);
                        playerNameTextController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
