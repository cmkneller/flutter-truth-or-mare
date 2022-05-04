import 'dart:ui';

import 'package:flutter/material.dart';
import 'welcome_round_amount_dialog.dart';

class AnimatedWelcomeButton extends StatelessWidget {
  const AnimatedWelcomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2)
        ,
        child: CircleAvatar(
          backgroundColor: Colors.white24,
          radius: 35,
          child: IconButton(
            iconSize: 40,
            onPressed: () {
              showDialog(
                  context: context, builder: (ctx) => const RoundAmountDialog());
            },
            icon: Icon(Icons.arrow_forward_ios_rounded),
            color: Colors.white,
            
          ),
        ),
      ),
    );
  }
}
