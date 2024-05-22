import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/home_page.dart';
import 'package:tic_tac_toe/widgets/custom_drawer_title.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.onRestart});

  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomDrawerTitle(),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Resume")),
            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRestart();
                },
                child: const Text("Restart")),
            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomePage.routeName);
                  ScaffoldMessenger.of(context).clearSnackBars();
                },
                child: const Text("Main Menu")),
          ],
        ),
      ),
    );
  }
}
