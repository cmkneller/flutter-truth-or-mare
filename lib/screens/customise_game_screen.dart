// Customise Game Screen Class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import '../providers/cards.dart';

import '../views/edit_tab_view.dart';
import '../widgets/customise_game/customise_app_bar.dart';

/// Uses a [TabBarView] widget to display screens allowing users to add/remove
/// their own [Truth]s or [Dares]
class CustomiseGameScreen extends StatelessWidget {
  static const String routName = '/customisegame';

  const CustomiseGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomiseAppBar(),
        body: TabBarView(children: [
          EditTabView(CardElement.truth),
          EditTabView(CardElement.dare),
        ]),
      ),
      
    );
  }
}

