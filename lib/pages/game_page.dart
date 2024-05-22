import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/services/audio_helper.dart';
import 'package:tic_tac_toe/services/helper.dart';
import 'package:tic_tac_toe/widgets/custom_drawer.dart';
import 'package:tic_tac_toe/widgets/custom_xo.dart';
import 'package:tic_tac_toe/widgets/winner_dialog.dart';

class GamePage extends StatefulWidget {
  const GamePage(
      {super.key,
      required this.isSinglePlayer,
      this.difficulty = "",
      this.player1Name = "",
      this.player2Name = ""});

  static String routeName = "/singleplayer";
  final bool isSinglePlayer;
  final String difficulty;
  final String player1Name;
  final String player2Name;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board = List.filled(9, "");
  bool isYourTurn = Random().nextBool();
  bool isGameOver = false;
  List<int>? _winningCombination;

  final ConfettiController _confettiController = ConfettiController();
  final AudioHelper _audioHelper = AudioHelper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTurnSnackBar();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioHelper.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: CustomDrawer(
          onRestart: _restartGame,
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: CustomPaint(
            foregroundPainter:
                LinePainter(winningCombination: _winningCombination),
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if ((widget.isSinglePlayer && isYourTurn) ||
                        !widget.isSinglePlayer) {
                      if (_audioHelper.clickPlayer.state ==
                          PlayerState.playing) {
                        _audioHelper.clickPlayer.stop();
                      }
                      _addMark(index);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5),
                        color: const Color(0xFFE1F7F5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          shouldLoop: true,
                          child: CustomXO(symbol: board[index])),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Restart Game by reseting the game parameters
  void _restartGame() {
    setState(() {
      board = List.filled(9, "");
      isYourTurn = Random().nextBool();
      isGameOver = false;
      _winningCombination = null;
      _confettiController.stop();
      if (_audioHelper.winPlayer.state == PlayerState.playing) {
        _audioHelper.winPlayer.stop();
      }
    });
    _showTurnSnackBar();
  }

  /// Play your turn
  void _addMark(int index) {
    setState(() {
      if (board[index].isNotEmpty || isGameOver) return;
      board[index] = isYourTurn ? "O" : "X";
      isYourTurn = !isYourTurn;
      _showTurnSnackBar();
      _audioHelper.playClickAudio();

      List<int>? winningCombination = checkWinner(board);
      if (winningCombination != null) {
        if (widget.isSinglePlayer) {
          _audioHelper.playWinAudio(board[winningCombination[0]] == "O");
          _showWinnerDialog(board[winningCombination[0]] == "O" ? "You" : "CPU",
              winningCombination);
          board[winningCombination[0]] == "O"
              ? _confettiController.play()
              : null;
        } else {
          _showWinnerDialog(
              board[winningCombination[0]] == "O"
                  ? widget.player1Name
                  : widget.player2Name,
              winningCombination);
          _audioHelper.playWinAudio(true);
          _confettiController.play();
        }
      } else if (!board.contains('')) {
        _showWinnerDialog('Draw', null);
      }
    });
  }

  void _showWinnerDialog(String winner, List<int>? winningCombination) {
    isGameOver = true;
    ScaffoldMessenger.of(context).clearSnackBars();
    setState(() {
      // Trigger repaint with the winning combination
      _winningCombination = winningCombination;
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => WinnerDialog(
                winner: winner, isOTurn: isYourTurn, onRestart: _restartGame));
      },
    );
  }

  void _aiPlay() {
    if (widget.difficulty == "Easy") {
      List<int> emptyIndices = board
          .asMap()
          .entries
          .where((entry) => entry.value.isEmpty)
          .map((entry) => entry.key)
          .toList();
      if (emptyIndices.isNotEmpty) {
        final randomIndex = Random().nextInt(emptyIndices.length);
        _addMark(emptyIndices[randomIndex]);
      }
    } else if (widget.difficulty == "Hard") {
      final bestMove = _getBestMove();
      if (bestMove != -1) {
        _addMark(bestMove);
      }
    }
  }

  int _getBestMove() {
    int bestScore = -1000;
    int move = -1;
    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) {
        board[i] = "X"; // Assume AI is "X"
        int score = minimax(board, 0, false);
        board[i] = "";
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    return move;
  }

  void _showTurnSnackBar() {
    if (!isGameOver && !isYourTurn && widget.isSinglePlayer) {
      Future.delayed(const Duration(seconds: 1), () => _aiPlay());
    }
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 500),
        backgroundColor: isYourTurn ? Colors.blue : Colors.red,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        margin: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).size.height - 150),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white, width: 3)),
        content: Center(
          child: Text(
            "${widget.isSinglePlayer ? (isYourTurn ? "Your" : "CPU") : (isYourTurn ? widget.player1Name : widget.player2Name)} Turn",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final List<int>? winningCombination;

  LinePainter({this.winningCombination});

  @override
  void paint(Canvas canvas, Size size) {
    if (winningCombination == null) return;

    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    final boardSize = size.width; // Assuming a square board
    final tileSize = boardSize / 3;

    Offset getOffset(int index) {
      final row = index ~/ 3;
      final col = index % 3;
      final x = col * tileSize + tileSize / 2;
      final y = row * tileSize + tileSize / 2;
      return Offset(x, y);
    }

    final start = getOffset(winningCombination![0]);
    final end = getOffset(winningCombination![2]);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
