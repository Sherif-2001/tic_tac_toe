import 'package:flutter/material.dart';

class CustomDrawerTitle extends StatelessWidget {
  const CustomDrawerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text.rich(
            const TextSpan(children: [
              TextSpan(text: "TIC\n"),
              TextSpan(text: "TAC\n"),
              TextSpan(text: "TOE"),
            ]),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 60,
              foreground: Paint()
                ..strokeJoin = StrokeJoin.round
                ..style = PaintingStyle.stroke
                ..strokeWidth = 15
                ..color = Colors.white,
              shadows: const [Shadow(color: Colors.white, blurRadius: 100)],
            ),
          ),
        ),
        Center(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: "TIC\n", style: TextStyle(color: Colors.red[700])),
              const TextSpan(
                  text: "TAC\n", style: TextStyle(color: Colors.green)),
              TextSpan(text: "TOE", style: TextStyle(color: Colors.blue[700])),
            ]),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
