import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/game_page.dart';

class SinglePlayerDialog extends StatelessWidget {
  const SinglePlayerDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: FittedBox(
          child: Text(
            "Choose Difficulty",
          ),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const GamePage(isSinglePlayer: true, difficulty: "Easy"),
                ),
              );
            },
            child: const Text("Easy"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const GamePage(isSinglePlayer: true, difficulty: "Hard"),
                ),
              );
            },
            child: const Text("Hard"),
          )
        ],
      ),
    );
  }
}
