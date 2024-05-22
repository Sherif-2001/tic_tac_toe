import 'package:flutter/material.dart';

class WinnerDialog extends StatelessWidget {
  const WinnerDialog(
      {super.key,
      required this.winner,
      required this.onRestart,
      required this.isOTurn});

  final String winner;
  final bool isOTurn;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          winner == 'Draw' ? 'Draw!' : '$winner Won',
          style: TextStyle(
            color: winner == 'Draw'
                ? Colors.white
                : (isOTurn ? Colors.red : Colors.blue),
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              onRestart();
              Navigator.pop(context);
            },
            child: const Text('Play Again?'),
          ),
        ],
      ),
    );
  }
}
