// Truth or Dare offline mobile app.
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/screens/customise_game_screen.dart';
import 'package:truthormare/screens/error_screen.dart';
import 'package:truthormare/screens/round_intro_screen.dart';
import 'package:either_dart/either.dart';

// Import Screens

import 'screens/welcome_screen.dart';
import 'screens/player_setup_screen.dart';
import 'screens/player_intro_screen.dart';
import 'screens/main_game_screen.dart';
import 'screens/final_scores_screen.dart';

// Import providers

import './providers/game.dart';
import './providers/players.dart';
import './providers/cards.dart';

// Import database helper

import 'db/db_helper.dart';
import '../utility/failure.dart';


/// Main entry point to app
/// 
/// Method is async as the game relies on data fetched from a local DB.
Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Loads App Data from database before starting app:
  Either<Failure, Map<String, List>> appData = await DBHelper.getAppData();

  // passes appData to the MyApp class constructor
  return runApp(MyApp(appData));
}

/// Holds the build function and overall structure of the app.
///
/// Accepts [appData] map, proiding the application with locally saved
/// [Truth]s and [Dare]s.
class MyApp extends StatelessWidget {
  final Either<Failure, Map<String, List>> appData;

  const MyApp(this.appData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appData.fold(
      (failure) => MaterialApp(
       // Shows an error screen if accessing db throws an exception. 
        home: ErrorScreen(failure.errorContent),
      ),
      (data) => MultiProvider( 
        // provides the [Game] and [Player] states to be accessed when needed
        // throughout the application
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => PlayersProvider(),
            lazy: false,
          ),
          ChangeNotifierProxyProvider<PlayersProvider, GameProvider>(
            // this is set up as the GameProvider needs to know if there
            // are enough players in the game to start.
            create: (_) => GameProvider(),
            update: (_, playersProvider, gameProvider) =>
                gameProvider!..setPlayers(playersProvider.playerList),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CardsProvider(data),
            lazy: false,
          ),
        ],

        child: MaterialApp(
          title: 'Truth or Mare',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),

          home: const WelcomeScreen(),
          // Registering the required routes:
          routes: {
            WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
            CustomiseGameScreen.routName: (ctx) => const CustomiseGameScreen(),
            PlayerSetupScreen.routeName: (ctx) => const PlayerSetupScreen(),
            PlayerIntroScreen.routeName: (ctx) => const PlayerIntroScreen(),
            MainGameScreen.routeName: (ctx) => const MainGameScreen(),
            FinalScoresScreen.routeName: (ctx) => const FinalScoresScreen(),
            RoundIntroScreen.routeName: (ctx) => const RoundIntroScreen(),
          },
        ),
      ),
    );
  }
}
