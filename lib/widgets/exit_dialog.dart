import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Exit??")),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => SystemNavigator.pop(),
              child: const Text("Yes")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => Navigator.pop(context),
              child: const Text("No"))
        ],
      ),
    );
  }
}
