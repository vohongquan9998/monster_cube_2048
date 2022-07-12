import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/puzzle_board.dart';

class GameOverPuzzleWidget extends StatefulWidget {
  final Puzzle_Board board;
  final MediaQueryData queryData;

  const GameOverPuzzleWidget({Key key, this.board, this.queryData})
      : super(key: key);

  @override
  _GameOverPuzzleWidgetState createState() => _GameOverPuzzleWidgetState();
}

class _GameOverPuzzleWidgetState extends State<GameOverPuzzleWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
    return Column(
      children: [
        SizedBox(
          height: widget.queryData.size.height * .02,
        ),
        Container(
          width: widget.queryData.size.width,
          height: widget.queryData.size.height * .5,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(widget.queryData.size.width * .04),
                child: Container(
                  width: widget.queryData.size.width,
                  height: widget.queryData.size.height * .5,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(widget.queryData.size.width * .06),
                    child: Container(
                      width: widget.queryData.size.width,
                      height: widget.queryData.size.height * .5,
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: widget.queryData.size.height * .03,
                          ),
                          Text(
                            'GAME OVER',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w900,
                                fontSize: widget.queryData.size.height * .05),
                          ),
                          SizedBox(
                            height: widget.queryData.size.height * .03,
                          ),
                          Text(
                            'Bạn đã hết số lượt',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w900,
                                fontSize: widget.queryData.size.height * .02),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: widget.queryData.size.width * .2,
                right: widget.queryData.size.width * .2,
                child: GestureDetector(
                  onTap: () {
                    controller.forward(from: 0.0);
                  },
                  child: AnimatedBuilder(
                    animation: offsetAnimation,
                    builder: (context, child) {
                      if (offsetAnimation.value < 0.0)
                        print('${offsetAnimation.value + 8.0}');
                      return Padding(
                        padding: EdgeInsets.only(
                            left: offsetAnimation.value + 32,
                            right: 32 - offsetAnimation.value),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 32),
                          child: Image.asset(
                            'assets/layout/2048_gameOver_mon.png',
                            width: widget.queryData.size.width * .2,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
