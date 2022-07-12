import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';

class GameOverWidget extends StatefulWidget {
  final Board board;
  final MediaQueryData queryData;

  const GameOverWidget({Key key, this.board, this.queryData}) : super(key: key);

  @override
  _GameOverWidgetState createState() => _GameOverWidgetState();
}

class _GameOverWidgetState extends State<GameOverWidget>
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
                            height: widget.queryData.size.height * .02,
                          ),
                          Text(
                            'Scores',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                                fontSize: widget.queryData.size.height * .025),
                          ),
                          SizedBox(
                            height: widget.queryData.size.height * .02,
                          ),
                          Text(
                            '${widget.board.scores.toStringAsFixed(0)}',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                                fontSize: widget.queryData.size.height * .04),
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
