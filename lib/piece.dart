import 'package:flutter/material.dart';
import 'package:tetris_game/board.dart';
import 'package:tetris_game/values.dart';

class Piece {
  //type of tetris piece
  Tetromino type;
  Piece({required this.type});

  //the piece is just a list of integers
  List<int> position = [];

  //color of tetris piece
  Color get color {
    return tetrominoColor[type] ?? Colors.white;
  }

  //generate integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];

        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];

        break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];

        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];

        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];

        break;
      case Tetromino.Z:
        position = [-17, -16, -5, -6];

        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];

        break;
      default:
    }
  }

  //move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //rotate piece
  int rotationState = 1;
  void rotatePiece() {
    //new position
    List<int> newPosition = [];

    //rotate piece based on its type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            //assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            //assign new position
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = 0;
            }
            break;
        }

        break;

      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            //assign new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = 0;
            }
            break;
        }

        break;

      case Tetromino.O:
        break;

      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            //assign new position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = 0;
            }
            break;
        }

        break;

      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            //assign new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = 0;
            }
            break;
        }

        break;

      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            //assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            //check that the new position is valid
            if (piecePositionisValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation state
              rotationState = 0;
            }
            break;
        }

        break;
    }
  }

  //check if valid position
  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    //if position is taken , return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    //otherwise position is valid so return true
    else {
      return true;
    }
  }

  //check if piece on valid position
  bool piecePositionisValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColoccupied = false;

    for (int pos in piecePosition) {
      //reurn false if any position is already taken

      if (!positionIsValid(pos)) {
        return false;
      }
      int col = pos % rowLength;

      //check first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColoccupied = true;
      }
    }
    return !(firstColOccupied && lastColoccupied);
  }
}
