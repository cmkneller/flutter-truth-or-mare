import 'package:flutter/material.dart';

class AnimatedZoomText extends StatefulWidget {
  final Text text;
  AnimatedZoomText(this.text);
  State<AnimatedZoomText> createState() => _AnimatedZoomTextState();
}

class _AnimatedZoomTextState extends State<AnimatedZoomText> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      child: widget.text,
    );
  }
}
