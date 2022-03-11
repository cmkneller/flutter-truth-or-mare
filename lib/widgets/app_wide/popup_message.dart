import 'package:flutter/material.dart';

class PopupMessage extends StatelessWidget {
  final String messageContent;
  final bool isError;

  const PopupMessage({required this.messageContent, required this.isError});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isError ? "Error" : "Success"),
      content: Text(messageContent),
    );
  }
}
