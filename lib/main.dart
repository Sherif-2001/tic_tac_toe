import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/pages/home_page.dart';
import 'package:tic_tac_toe/pages/game_page.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        fontFamily: "GillSans",
        dialogTheme: customDialogTheme,
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: customElevatedButtonThemeData),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFFE1F7F5)),
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        GamePage.routeName: (context) => const GamePage(
              isSinglePlayer: true,
              difficulty: "Easy",
            ),
      },
    );
  }
}
