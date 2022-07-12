import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2048_program_language/src/formula_page.dart';
import 'package:flutter_2048_program_language/src/model/puzzle.dart';
import 'package:flutter_2048_program_language/src/model/puzzle_board.dart';
import 'package:flutter_2048_program_language/src/model/tile.dart';
import 'package:flutter_2048_program_language/src/utils/utils.dart';
import 'package:flutter_2048_program_language/src/widget/drag_event_puzzle.dart';
import 'package:flutter_2048_program_language/src/widget/formula_puzzle.dart';
import 'package:flutter_2048_program_language/src/widget/game_over_puzzle_widget.dart';
import 'package:flutter_2048_program_language/src/widget/messagebox.dart';
import 'package:flutter_2048_program_language/src/widget/tilebox.dart';

class Puzzle_Page_Screen extends StatelessWidget {
  final _Puzzle_PageState state;

  const Puzzle_Page_Screen({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size boardSize = state.boardSize();
    Size size = MediaQuery.of(context).size;
    double width = (boardSize.width - (state.column + 1) * state.tilePadding) /
        state.column;

    List<TileBox> bgbox = List<TileBox>();

    for (int r = 0; r < state.row; ++r) {
      for (int c = 0; c < state.column; ++c) {
        TileBox tile = TileBox(
          left: c * width * state.tilePadding * (c + 1),
          top: r * width * state.tilePadding * (r - 2),
          size: width,
          image: "",
        );
        bgbox.add(tile);
      }
    }
    return Positioned(
      left: 0.0,
      top: 0.0,
      child: Container(
        width: state.boardSize().width,
        height: state.boardSize().width,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Stack(
          children: [
            Positioned.fill(
                child: Padding(
              padding: EdgeInsets.all(size.width * .01),
              child: Image.asset('assets/layout/$HUD_tile_B.png'),
            )),
            Stack(
              children: bgbox,
            ),
          ],
        ),
      ),
    );
  }
}

class Puzzle_Page extends StatefulWidget {
  final int index;

  const Puzzle_Page({Key key, this.index}) : super(key: key);
  @override
  State<Puzzle_Page> createState() => _Puzzle_PageState();
}

class _Puzzle_PageState extends State<Puzzle_Page> {
  Puzzle_Board _board;
  int row;
  int column;
  bool _isMoving;
  bool _gameOver;
  bool _win;
  double tilePadding = 4.0;
  MediaQueryData _queryData;
  bool _isTapRequiredMonster;
  bool _isTapSolvePuzzle;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    row = 5;
    column = 5;
    _isMoving = false;
    _gameOver = false;
    _win = false;
    _isTapRequiredMonster = false;
    _isTapSolvePuzzle = false;
    _board = Puzzle_Board(columm: column, row: row);
    NewGame();
  }

  Future<void> NewGame() async {
    setState(() {
      _board.initBoard(widget.index);
      _gameOver = false;
      _isTapSolvePuzzle = false;
      _win = false;
    });
  }

  Size boardSize() {
    Size size = _queryData.size;
    return Size(size.width, size.width);
  }

  void GameOver() {
    setState(() {
      if (_board.GameOver()) {
        _board.count = 0;
        return _gameOver = true;
      }
    });
  }

  void Winning() {
    setState(() {
      if (_board.WinGame()) return _win = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _queryData = MediaQuery.of(context);
    List<TilePuzzleWidget> _tileWidget = List<TilePuzzleWidget>();

    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        _tileWidget.add(TilePuzzleWidget(
          tile: _board.getTile(r, c),
          state: this,
        ));
      }
    }
    // ignore: deprecated_member_use
    List<Widget> children = List<Widget>();

    children.add(Puzzle_Page_Screen(state: this));
    children.addAll(_tileWidget);

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: _key,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: bgGradientB),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: _queryData.size.width,
                height: _queryData.size.height * .17,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/layout/$HUD_topG.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: _queryData.size.width * .05,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MessageBox(
                                    text: "Bắt đầu lại từ đầu nhé ?",
                                    onPress: () {
                                      Navigator.pop(context);
                                      NewGame();
                                    },
                                  );
                                });
                          },
                          child: Container(
                              width: _queryData.size.width * .19,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Image.asset(
                                'assets/layout/$HUD_restart_button_G.png',
                                width: _queryData.size.width * .2,
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                        SizedBox(
                          width: _queryData.size.width * .09,
                        ),
                        Container(
                          height: _queryData.size.height * .19,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: _queryData.size.height * .01),
                                child: Container(
                                  width: _queryData.size.width * .6,
                                  height: _queryData.size.height * .035,
                                  decoration:
                                      BoxDecoration(color: Colors.transparent),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Số lượt còn lại :",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                _queryData.size.height * .02,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: _queryData.size.width * .01,
                                      ),
                                      Text(
                                        "${_board.count}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: _board.count == 0
                                                ? Colors.red
                                                : Colors.white,
                                            fontSize:
                                                _queryData.size.height * .024,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _queryData.size.height * .012,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MessageBox(
                                          text:
                                              "Trở về màn hình chính?(Tiến trình sẽ không được lưu)",
                                          onPress: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                        );
                                      });
                                },
                                child: Container(
                                  width: _queryData.size.width * .1,
                                  height: _queryData.size.width * .1,
                                  child: Center(
                                      child: Image.asset(
                                    'assets/layout/$HUD_return_button_G.png',
                                    width: _queryData.size.width * .09,
                                    fit: BoxFit.fitWidth,
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _queryData.size.height > max_height
                    ? (_queryData.size.width +
                            (_queryData.size.height * .15) +
                            (_queryData.size.width * .15)) /
                        10
                    : _queryData.size.width * .05,
                child: _isTapSolvePuzzle
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _queryData.size.width * .04),
                        child: Container(
                          width: _queryData.size.width,
                          color: Colors.transparent,
                          child: ListView.builder(
                              itemCount:
                                  getListPuzzle()[widget.index].solve.length,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: _queryData.size.height * .01),
                                  child: Container(
                                    color: Colors.transparent,
                                    width: _queryData.size.width * .25,
                                    height: _queryData.size.height * .1,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            getListPuzzle()[widget.index]
                                                .solve[index]
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize:
                                                    _queryData.size.height *
                                                        .02,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          index <
                                                  getListPuzzle()[widget.index]
                                                          .solve
                                                          .length -
                                                      1
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_sharp,
                                                      size: _queryData
                                                              .size.height *
                                                          .025,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_sharp,
                                                      size: _queryData
                                                              .size.height *
                                                          .025,
                                                    ),
                                                  ],
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              !_gameOver
                  ? Stack(
                      children: [
                        Container(
                          width: _queryData.size.width,
                          height: _queryData.size.width,
                          child: Drag_Event_Puzzle(
                            children: children,
                            board: _board,
                            gameOver: GameOver,
                            win: Winning,
                          ),
                        ),
                        !_win
                            ? SizedBox.shrink()
                            : Positioned(
                                top: _queryData.size.height * .1,
                                left: _queryData.size.width * .2,
                                right: _queryData.size.width * .2,
                                child: Container(
                                  width: _queryData.size.width * .7,
                                  height: _queryData.size.height * .25,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.brown.shade900.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Stage Complete'.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w900,
                                              fontSize:
                                                  _queryData.size.height * .05),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              width:
                                                  _queryData.size.width * .25,
                                              height:
                                                  _queryData.size.height * .05,
                                              color: Colors.white70,
                                              child: Center(
                                                  child: Text("Choose stage"))),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )
                  : GameOverPuzzleWidget(
                      board: _board,
                      queryData: _queryData,
                    ),
              Spacer(),
              Opacity(
                opacity: _isTapRequiredMonster ? 1.0 : 0.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _queryData.size.width * .03),
                  child: Stack(
                    children: [
                      Container(
                        width: _queryData.size.width * .8,
                        height: _queryData.size.height * .05,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                      Positioned(
                        top: _queryData.size.height * .01,
                        bottom: _queryData.size.height * .01,
                        child: Container(
                          width: _queryData.size.width * .8,
                          height: _queryData.size.height * .03,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Quái vật cần thiết để chiến thắng màn chơi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: _queryData.size.height * .015,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/monster/' +
                            tileImage[
                                getListPuzzle()[widget.index].required[0]] +
                            ".png",
                        width: _queryData.size.width * .1,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: _queryData.size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/layout/icon_2048_bottom_hud_2.png',
                        width: _queryData.size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: _queryData.size.height * .005),
                      child: Row(
                        children: [
                          Container(
                            width: _queryData.size.width * .37,
                            height: _queryData.size.height * .14,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: _queryData.size.width * .064,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isTapRequiredMonster =
                                          !_isTapRequiredMonster;
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/monster/' +
                                        tileImage[getListPuzzle()[widget.index]
                                            .required[0]] +
                                        ".png",
                                    width: _queryData.size.width * .143,
                                  ),
                                ),
                                SizedBox(
                                  width: _queryData.size.width * .071,
                                ),
                                Text(
                                  getListPuzzle()[widget.index]
                                      .required_value[0]
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade100,
                                    fontSize: _queryData.size.height * .02,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              !_isTapSolvePuzzle && !_gameOver
                                  ? showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MessageBox(
                                          text:
                                              "Dùng trợ giúp chứ?(Miễn phí khi dùng bản thử nghiệm)",
                                          onPress: () {
                                            setState(() {
                                              Navigator.pop(context);
                                              _isTapSolvePuzzle = true;
                                            });
                                          },
                                        );
                                      })
                                  : () {};
                            },
                            child: Container(
                              width: _queryData.size.width * .26,
                              height: _queryData.size.height * .14,
                              color: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: _queryData.size.width * .13,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Formula_Puzzle_Page()));
                            },
                            child: Container(
                              width: _queryData.size.width * .14,
                              height: _queryData.size.width * .15,
                              child: Center(
                                  child: Image.asset(
                                'assets/layout/$fxfTitle.png',
                                fit: BoxFit.fitWidth,
                                width: _queryData.size.width * .15,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedPuzzleTileWidget extends AnimatedWidget {
  final Tile tile;
  final _Puzzle_PageState state;

  AnimatedPuzzleTileWidget(
      {Key key, this.tile, this.state, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    double animationValue = animation.value;
    Size boardSize = state.boardSize();
    double width = (boardSize.width - (state.column + 1) * state.tilePadding) /
        (state.column);

    if (tile.value == 0) {
      return Container();
    } else {
      return TileBox(
        left: (tile.column * width + state.tilePadding * (tile.column + 1)) +
            width / 2 * (1 - animationValue),
        top: tile.row * width +
            state.tilePadding * (tile.row + 1) +
            width / 2 * (1 - animationValue),
        size: width * animationValue,
        image: tileImage.containsKey(tile.value) ? tileImage[tile.value] : "",
      );
    }
  }
}

class TilePuzzleWidget extends StatefulWidget {
  final Tile tile;
  final _Puzzle_PageState state;

  const TilePuzzleWidget({Key key, this.tile, this.state}) : super(key: key);

  @override
  _TilePuzzleWidgetState createState() => _TilePuzzleWidgetState();
}

class _TilePuzzleWidgetState extends State<TilePuzzleWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    widget.tile.isNew = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tile.isNew && !widget.tile.isEmpty()) {
      controller.reset();
      controller.forward();
      widget.tile.isNew = false;
    } else {
      controller.animateTo(1.0);
    }
    return AnimatedPuzzleTileWidget(
      tile: widget.tile,
      state: widget.state,
      animation: animation,
    );
  }
}
