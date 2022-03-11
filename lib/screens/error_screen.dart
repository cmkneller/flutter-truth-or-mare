// Error Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';

/// Returns a [Scaffold] widget with the [errorContent] param text displayed
/// In a [Center] for the body parameter. 
class ErrorScreen extends StatelessWidget {
  final String errorContent;
  const ErrorScreen(this.errorContent, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Error!",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),

      body: Center(child: Text(errorContent),),
    );
  }
}
