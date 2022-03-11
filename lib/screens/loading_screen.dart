// Loading Screen class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';

// Simple loading screen widget, created statefull to implement animations.
class LoadingScreen extends StatefulWidget {
  static const routeName = '/loadingscreen';

  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Loading"),),
    );
  }
}
