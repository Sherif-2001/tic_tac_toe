import 'package:flutter/material.dart';

class CustomXO extends StatelessWidget {
  const CustomXO({
    super.key,
    required this.symbol,
  });

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      scale: symbol.isEmpty ? 0 : 1,
      child: Stack(
        children: [
          Center(
            child: Text(symbol,
                style: TextStyle(
                  fontSize: 60,
                  foreground: Paint()
                    ..strokeJoin = StrokeJoin.round
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 13
                    ..color = Colors.black,
                )),
          ),
          Center(
            child: Text(
              symbol,
              style: TextStyle(
                color: symbol == "X" ? Colors.red : Colors.blue,
                fontSize: 60,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
