import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text.rich(
            const TextSpan(children: [
              TextSpan(text: "TIC "),
              TextSpan(text: "TAC "),
              TextSpan(text: "TOE"),
            ]),
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
              TextSpan(text: "TIC ", style: TextStyle(color: Colors.red[700])),
              const TextSpan(
                  text: "TAC ", style: TextStyle(color: Colors.green)),
              TextSpan(text: "TOE", style: TextStyle(color: Colors.blue[700])),
            ]),
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
