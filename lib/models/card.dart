enum cardElement { truth, dare }

class Truth {
  final int _id;
  final String _text;
  final bool playerGen;
  int _priority;

  Truth(this._id, this._text, this.playerGen, this._priority);

  int get id {
    return _id;
  }

  String get text {
    return _text;
  }

  int get priority {
    return _priority;
  }

  void setPriority(int priority) {
    _priority = priority;
  }

  void lowerPriority() {
    setPriority(priority - 1);
  }
}

class Dare {
  final int _id;
  final String _text;
  final bool _playerGen;
  bool _used = false;
  int _priority;

  Dare(this._id, this._text, this._playerGen, this._priority);

  int get id {
    return _id;
  }

  String get text {
    return _text;
  }

  bool get isPlayerGen {
    return _playerGen;
  }

  bool get isUsed {
    return _used;
  }

  void setUsed() {
    _used = !_used;
  }

  int get priority {
    return _priority;
  }

  void setPriority(int priority) {
    _priority = priority;
  }

  void lowerPriority() {
    setPriority(priority - 1);
  }
}
