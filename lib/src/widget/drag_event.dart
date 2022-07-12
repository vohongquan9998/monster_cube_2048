import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';

class DragEvent extends StatefulWidget {
  final List<Widget> children;

  final Board board;
  final Function gameOver;

  const DragEvent({Key key, this.board, this.gameOver, this.children})
      : super(key: key);

  @override
  State<DragEvent> createState() => _DragEventState();
}

class _DragEventState extends State<DragEvent>
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
          });
        } else {
          setState(() {
            widget.board.moveUp();
            widget.gameOver();
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
          });
        } else {
          setState(() {
            widget.board.moveRight();
            widget.gameOver();
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
