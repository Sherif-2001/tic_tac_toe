import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/game_page.dart';
import 'package:tic_tac_toe/widgets/custom_textformfield.dart';

final _formKey = GlobalKey<FormState>();

class MultiplayerDialog extends StatelessWidget {
  MultiplayerDialog({super.key});

  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const FittedBox(child: Text("Players Names")),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              label: "Player 1 Name",
              controller: _player1Controller,
            ),
            CustomTextFormField(
              label: "Player 2 Name",
              controller: _player2Controller,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                          isSinglePlayer: false,
                          player1Name: _player1Controller.text,
                          player2Name: _player2Controller.text),
                    ),
                  );
                }
              },
              child: const Text("Start"),
            )
          ],
        ),
      ),
    );
  }
}
