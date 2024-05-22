import 'dart:math';

/// Check the winner by comparing the board to the winning combinations
List<int>? checkWinner(List<String> board) {
  List<List<int>> winningCombinations = [
    [0, 1, 2], // Row 1
    [3, 4, 5], // Row 2
    [6, 7, 8], // Row 3
    [0, 3, 6], // Column 1
    [1, 4, 7], // Column 2
    [2, 5, 8], // Column 3
    [0, 4, 8], // Diagonal 1
    [2, 4, 6], // Diagonal 2
  ];

  for (List<int> combination in winningCombinations) {
    if (board[combination[0]].isNotEmpty &&
        board[combination[0]] == board[combination[1]] &&
        board[combination[1]] == board[combination[2]]) {
      return combination;
    }
  }
  return null;
}

int minimax(List<String> board, int depth, bool isMaximizing) {
  List<int>? winningCombination = checkWinner(board);
  if (winningCombination != null) {
    if (board[winningCombination[0]] == "X") return 10 - depth;
    if (board[winningCombination[0]] == "O") return depth - 10;
  }
  if (!board.contains('')) return 0;

  if (isMaximizing) {
    int bestScore = -1000;
    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) {
        board[i] = "X";
        int score = minimax(board, depth + 1, false);
        board[i] = "";
        bestScore = max(score, bestScore);
      }
    }
    return bestScore;
  } else {
    int bestScore = 1000;
    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) {
        board[i] = "O";
        int score = minimax(board, depth + 1, true);
        board[i] = "";
        bestScore = min(score, bestScore);
      }
    }
    return bestScore;
  }
}
