import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/custom_title.dart';
import 'package:tic_tac_toe/widgets/exit_dialog.dart';
import 'package:tic_tac_toe/widgets/mutliplayer_dialog.dart';
import 'package:tic_tac_toe/widgets/singleplayer_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back.jpg"),
                fit: BoxFit.cover,
                opacity: 0.7,
                isAntiAlias: true,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomTitle(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const SinglePlayerDialog(),
                            );
                          },
                          icon: const Icon(Icons.person),
                          label: const Text("Single Player")),
                      const SizedBox(height: 25),
                      ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => MultiplayerDialog(),
                            );
                          },
                          icon: const Icon(Icons.group),
                          label: const Text("Multiplayer")),
                      const SizedBox(height: 25),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const ExitDialog(),
                          );
                        },
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text("Exit"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
