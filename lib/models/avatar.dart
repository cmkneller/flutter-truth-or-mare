import 'package:truthormare/utility/constants.dart';

class Avatar {
  final int _id;
  late String _fullImageUrl; // Shown in slider/player display screens
  late String _smallImageUrl; // Shown in top-corner of gameplay mode
  bool _isUsed = false; // Is the avater in use?
  bool _isAvailabe = true; // Is the avatar available?


  Avatar(this._id) {
    // Generates image paths to avatars
    _fullImageUrl = Constants.PATH_AVATARS + "full-" + _id.toString() + ".png";
    _smallImageUrl =
        Constants.PATH_AVATARS + "small-" + _id.toString() + ".png";
  }

  String get fullImageUrl {
    return _fullImageUrl;
  }

  String get smallImageUrl {
    return _smallImageUrl;
  }

  int get id {
    return _id;
  }

  bool get getUsedStatus {
    return _isUsed;
  }

  bool get isAvailable {
    return _isAvailabe;
  }

  void setAvailability(bool availablity) {
    _isAvailabe = availablity;
  }

  void avatarSelected(bool status) {
    _isUsed = status;
  }
}
