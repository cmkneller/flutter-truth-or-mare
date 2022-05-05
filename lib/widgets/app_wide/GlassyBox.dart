import 'package:flutter/material.dart';
import 'dart:ui';

class GlassyBox extends StatelessWidget {
  GlassyBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.topPosition,
      this.padding,
      required this.title,
      required this.content,
      this.blurAmount,
      this.callToAction})
      : super(key: key);

  final double width;
  final double height;
  final double topPosition;
  final String title;
  final String content;
  double? blurAmount;

  String? callToAction;
  double? padding;

  void pageEndAnimation() {}

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: deviceHeight * topPosition,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: blurAmount != null ? blurAmount! : 10,
              sigmaY: blurAmount != null ? blurAmount! : 10),
          child: Container(
            padding: EdgeInsets.all(deviceWidth * 0.15),
            height: deviceHeight * height,
            width: deviceWidth * width,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white54, Colors.white10]),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.white, width: 0.5)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  Text(content,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center),
                  if (callToAction != null)
                    Text(
                      callToAction!,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                ]),
          ),
        ),
      ),
    );
  }
}
