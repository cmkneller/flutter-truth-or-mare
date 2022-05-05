import 'dart:ui';

import 'package:flutter/material.dart';
import 'welcome_round_amount_dialog.dart';

class GlossyButton extends StatelessWidget {
  final Icon chosenIcon;
  final Function callback;
  final double size;

  const GlossyButton(
    this.chosenIcon,
    this.callback,
    this.size, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: CircleAvatar(
            backgroundColor: Colors.white24,
            radius: size,
            child: IconButton(
              iconSize: size,
              onPressed: () {
                callback();
              },
              icon: chosenIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
