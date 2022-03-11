import 'package:flutter/material.dart';
import 'package:truthormare/models/player.dart';

class PlayerAvatar extends StatelessWidget {
  final Avatar _playerAvatar;
  final String avatarUsedImagePath =
      'assets/images/app-wide/avatars/avatar-used.png';

  final Function _selectFunction;

  const PlayerAvatar(this._playerAvatar, this._selectFunction, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAvailable = _playerAvatar.isAvailable;

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          _selectFunction(_playerAvatar.id);
        }
      },
      child: Opacity(
        opacity: _playerAvatar.getUsedStatus ? 1 : 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 30,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    _playerAvatar.getImageUrl,
                    width: 50,
                  ),
                ),
                if (!isAvailable)
                  Center(
                    child: Image.asset(
                      avatarUsedImagePath,
                      width: 60,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
