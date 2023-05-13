import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

import 'piece.dart';

//create a game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(rowLength, (j) => null),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
// current tetris piece
  Piece carrentPiece = Piece(type: Tetromino.Z);

  // currentscore
  int currentScore = 0;

  //game over status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    //start the game when app start
    startGame();
  }

  void startGame() {
    carrentPiece.initializePiece();

    //frame refresh rate
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  //game Loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        //clear lines
        clearLines();

        //check landing
        checkLanding();

        // check if game over
        if (gameOver == true) {
          timer.cancel();
          showGameoverdialog();
        }

        //move current piece down
        carrentPiece.movePiece(Direction.down);
      });
    });
  }

  //game over msg
  void showGameoverdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("Your score is :$currentScore"),
        actions: [
          TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
              },
              child: const Text("Play Again"))
        ],
      ),
    );
  }

  //reset game
  resetGame() {
    gameBoard =
        List.generate(colLength, (i) => List.generate(rowLength, (j) => null));
    gameOver = false;
    currentScore = 0;

    createNewPIece();
    startGame();
  }

  //check for collision in a future position
  //return true-> there is a colliion
  //return false-> there is no colliion
  bool checkCollision(Direction direction) {
    //loop each position of the current piece
    for (int i = 0; i < carrentPiece.position.length; i++) {
      //calculate the row and column of the current postion
      int row = (carrentPiece.position[i] / rowLength).floor();
      int col = carrentPiece.position[i] % rowLength;

      //adjust col and row based on direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }
      //check if piece is out of bounds(too low , too left, right)
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      } else if (col > 0 && row > 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    //if no collision detected , return false
    return false;
  }

  void checkLanding() {
    //if going down is occupied
    if (checkCollision(Direction.down)) {
      //mark position as accupied on the gameboard
      for (int i = 0; i < carrentPiece.position.length; i++) {
        int row = (carrentPiece.position[i] / rowLength).floor();
        int col = carrentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = carrentPiece.type;
        }
      }
      //once it landed create new piece
      createNewPIece();
    }
  }

  void createNewPIece() {
    //create random object to generate random tetromino pieces
    Random rand = Random();

    //craete new piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    carrentPiece = Piece(type: randomType);
    carrentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    //make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        carrentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    //make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        carrentPiece.movePiece(Direction.right);
      });
    }
  }

// rotate piece
  void rotatePiece() {
    setState(() {
      carrentPiece.rotatePiece();
    });
  }

  // clear line
  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowisFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowisFull = false;
          break;
        }
      }

      if (rowisFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);

        currentScore++;
      }
    }
  }

  // game over

  bool isGameOver() {
    //check if any column in the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //game gridview
          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rowLength * colLength,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                // ignore: body_might_complete_normally_nullable
                itemBuilder: (context, index) {
                  //get row and col of each index
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  //current piiece
                  if (carrentPiece.position.contains(index)) {
                    return Pixel(
                      color: carrentPiece.color,
                    );
                  }
                  //landed pieces

                  else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                      color: tetrominoColor[tetrominoType],
                    );
                  }
                  //blank pixel

                  else {
                    return Pixel(
                      color: Colors.grey[900],
                    );
                  }
                }),
          ),

          Text(
            "Score: $currentScore",
            style: const TextStyle(color: Colors.white),
          ),
          //game controls
          Padding(
            padding: const EdgeInsets.only(bottom: 50, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: moveLeft,
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: rotatePiece,
                    color: Colors.white,
                    icon: const Icon(Icons.rotate_right)),
                IconButton(
                    onPressed: moveRight,
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_forward_ios)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
