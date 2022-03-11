// Failure class
// Author: Chris Kneller
// Date March 2022
// Version 1.

/// Class for a failure object, generated when internal db errors occur.
class Failure {
  final String errorMessage;

  Failure(this.errorMessage);

  String get errorContent {
    return errorMessage;
  }
}
