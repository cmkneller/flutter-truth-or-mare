import 'package:flutter/material.dart';
import '../../models/card.dart';

class TruthCard extends StatelessWidget {
  const TruthCard(
    this.truth, {
    Key? key,
  }) : super(key: key);

  final Truth truth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Truth",
                style: TextStyle(fontSize: 24),
              ),
             const SizedBox(
                height: 25,
              ),
              Text(truth.text)
            ],
          ),
        ),
      ),
    );
  }
}
