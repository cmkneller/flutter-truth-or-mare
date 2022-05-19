import 'dart:ui';

import 'package:flutter/material.dart';
import '../welcome/welcome_round_amount_dialog.dart';

class GlossyButton extends StatelessWidget {
  final Icon chosenIcon;
  final Function callback;
  final double size;
  Color? _color;

  GlossyButton(
    this.chosenIcon,
    this.callback,
    this.size,
    [this._color = Colors.white24]
  );

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 0.4),
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
            backgroundColor: _color,
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
