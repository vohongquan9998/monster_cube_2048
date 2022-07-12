import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/puzzle_board.dart';

class Drag_Event_Puzzle extends StatefulWidget {
  final List<Widget> children;

  final Puzzle_Board board;
  final Function gameOver;
  final Function win;

  const Drag_Event_Puzzle(
      {Key key, this.board, this.gameOver, this.children, this.win})
      : super(key: key);

  @override
  State<Drag_Event_Puzzle> createState() => _Drag_Event_PuzzleState();
}

class _Drag_Event_PuzzleState extends State<Drag_Event_Puzzle>
    with SingleTickerProviderStateMixin {
  bool _isMoving;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        if (detail.delta.distance == 0 || _isMoving) {
          return;
        }
        _isMoving = true;
        if (detail.delta.direction > 0) {
          setState(() {
            widget.board.moveDown();
            widget.gameOver();
            widget.win();
          });
        } else {
          setState(() {
            widget.board.moveUp();
            widget.gameOver();
            widget.win();
          });
        }
      },
      onVerticalDragEnd: (d) {
        _isMoving = false;
      },
      onVerticalDragCancel: () {
        _isMoving = false;
      },
      onHorizontalDragUpdate: (d) {
        if (d.delta.distance == 0 || _isMoving) {
          return;
        }
        _isMoving = true;
        if (d.delta.direction > 0) {
          setState(() {
            widget.board.moveLeft();
            widget.gameOver();
            widget.win();
          });
        } else {
          setState(() {
            widget.board.moveRight();
            widget.gameOver();
            widget.win();
          });
        }
      },
      onHorizontalDragEnd: (d) {
        _isMoving = false;
      },
      onHorizontalDragCancel: () {
        _isMoving = false;
      },
      child: Stack(
        children: widget.children,
      ),
    );
  }
}
