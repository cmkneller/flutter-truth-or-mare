import 'package:flutter/material.dart';
import 'welcome_round_amount_dialog.dart';

class AnimatedWelcomeButton extends StatelessWidget {
  const AnimatedWelcomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(context: context, builder: (ctx) => const RoundAmountDialog());
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
          shadowColor: const Color.fromRGBO(0, 0, 0, .2),
          elevation: 10,
          primary: Colors.white),
      child: const Text(
        'Create Game',
        style: TextStyle(fontSize: 24, color: Colors.black26),
      ),
    );
  }
}
