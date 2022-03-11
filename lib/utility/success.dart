// Success class
// Author: Chris Kneller
// Date March 2022
// Version 1.

/// Class for a Success object, generated when elements are saved to db.
class Success {
  final String successMessage;

  Success(this.successMessage);

  String get successContent {
    return successMessage;
  }
}
