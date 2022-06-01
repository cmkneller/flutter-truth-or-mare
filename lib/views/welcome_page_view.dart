import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/intro.dart';
import '../pages/round_number.dart';
import '../providers/navigation.dart';

class WelcomePageView extends StatefulWidget {
  final double _deviceHeight;
  WelcomePageView(this._deviceHeight, {Key? key}) : super(key: key);
  @override
  _WelcomePageViewState createState() => _WelcomePageViewState();
}

class _WelcomePageViewState extends State<WelcomePageView> {
  final PageController _pageController = PageController();
  bool built = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NavigationProvider pageLogic = Provider.of<NavigationProvider>(context);
    if (built && pageLogic.pageID != _pageController.page?.floor()) {
      _pageController.animateToPage(pageLogic.pageID,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    built = true;

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [intro(deviceHeight: widget._deviceHeight), RoundNumber()],
    );
  }
}
