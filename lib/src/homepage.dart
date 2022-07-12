import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/dex_page.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';
import 'package:flutter_2048_program_language/src/model/tile.dart';

import 'package:flutter_2048_program_language/src/utils/dex_data.dart';
import 'package:flutter_2048_program_language/src/utils/utils.dart';
import 'package:flutter_2048_program_language/src/widget/drag_event.dart';
import 'package:flutter_2048_program_language/src/widget/drawer_item.dart';
import 'package:flutter_2048_program_language/src/widget/drawer_monster_upgrade.dart';
import 'package:flutter_2048_program_language/src/widget/game_over_widget.dart';
import 'package:flutter_2048_program_language/src/widget/messagebox.dart';
import 'package:flutter_2048_program_language/src/widget/tilebox.dart';
import 'formula_page.dart';

class HomePage extends StatelessWidget {
  final _BoardWidgetState state;
  final Clan clan;
  const HomePage({Key key, this.state, this.clan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size boardSize = state.boardSize();
    Size size = MediaQuery.of(context).size;
    double width = (boardSize.width - (state.column + 1) * state.tilePadding) /
        state.column;
    // ignore: deprecated_member_use
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
    String getTileHUD() {
      if (clan == Clan.Red) {
        return HUD_tile_R;
      }
      if (clan == Clan.Blue) {
        return HUD_tile_B;
      }
      if (clan == Clan.Green) {
        return HUD_tile_G;
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
              child: Image.asset('assets/layout/${getTileHUD()}.png'),
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

class BoardWidget extends StatefulWidget {
  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget>
    with AutomaticKeepAliveClientMixin {
  Board _board;
  int row;
  int column;
  bool _isMoving;
  bool _gameOver;
  double tilePadding = 4.0;
  MediaQueryData _queryData;
  Clan clan;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool _isPlayingMusic;
  static AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  static AudioCache musicCache = AudioCache(fixedPlayer: audioPlayer);

  Timer timer;
  int _index = 0;

  bool _isMonster = false;
  bool _isActiveAnimation = false;
  bool _isAnimationOn = false;
  int buy_index;

  @override
  void initState() {
    super.initState();
    row = 5;
    column = 5;
    _isMoving = false;
    _gameOver = false;
    clan = Clan.Red;
    _board = Board(columm: column, row: row);
    _isPlayingMusic = true;
    buy_index = 0;
    // timer = Timer.periodic(Duration(seconds: 25), (timer) {
    //   setState(() => _index < imageSwitch.length ? _index++ : _index = 0);
    // });
    playLocal();

    NewGame();
  }

  String getHUD(String r, String b, String g) {
    if (clan == Clan.Red) {
      return r;
    }
    if (clan == Clan.Blue) {
      return b;
    }
    if (clan == Clan.Green) {
      return g;
    }
  }
  // Future getData() async {
  //   dynamic data;
  //   await SharedPreferencesSevices.init();
  //   data = await SharedPreferencesSevices.getData();
  //   data = {'scores': _board.scores, 'skill': _board.skill_point};
  //   print(data);
  //   return data;
  // }

  Future playLocal() async {
    if (audioPlayer.state == PlayerState.PAUSED) {
      audioPlayer.resume();
    } else {
      if (_isActiveAnimation) {
        audioPlayer = await musicCache.loop('audio/FastFeelBananaPeel.m4a',
            volume: .7, stayAwake: true);
      }
    }
  }

  @override
  void dispose() {
    //timer.cancel();
    super.dispose();
  }

  Future pauseLocal() async {
    audioPlayer.stop();
  }

  void NewGame() {
    setState(() {
      _board.initBoard(Clan.Blue);
      _gameOver = false;
    });
  }

  void GameOver() {
    setState(() {
      if (_board.GameOver()) return _gameOver = true;
      if (_board.scores > maxScores) return _gameOver = true;
    });
  }

  Size boardSize() {
    Size size = _queryData.size;
    return Size(size.width, size.width);
  }

  @override
  Widget build(BuildContext context) {
    _queryData = MediaQuery.of(context);

    List<TileWidget> _tileWidget = List<TileWidget>();

    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        _tileWidget.add(TileWidget(
          tile: _board.getTile(r, c),
          state: this,
          clan: clan,
        ));
      }
    }

    // ignore: deprecated_member_use
    List<Widget> children = List<Widget>();

    children.add(HomePage(
      state: this,
      clan: clan,
    ));
    children.addAll(_tileWidget);

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: _key,
      drawer: Drawer(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/layout/old_paper.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              _isMonster
                  ? Drawer_Monster_Upgrade(
                      board: _board,
                      queryData: _queryData,
                    )
                  : Drawer_Items(
                      board: _board,
                      queryData: _queryData,
                    ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.green.shade200,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            pauseLocal();
            Navigator.pop(context);
          },
          child: !_isActiveAnimation
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.green.shade200,
                      Colors.green.shade100,
                      Colors.white70,
                      Colors.white70,
                      Colors.white70,
                      Colors.white70,
                      Colors.green.shade100,
                      Colors.green.shade200
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    width: _queryData.size.width,
                    height: _queryData.size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: _queryData.size.width * .8,
                          height: _queryData.size.height * .2,
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              'Choose your clan'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: _queryData.size.height * .03,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: _queryData.size.width * .3,
                              height: _queryData.size.height * .1,
                              color: Colors.transparent,
                              child: Center(
                                child: Text(
                                  '+1 tiles/turn',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: _queryData.size.height * .02),
                                ),
                              ),
                            ),
                            Container(
                              width: _queryData.size.width * .3,
                              height: _queryData.size.height * .1,
                              color: Colors.transparent,
                              child: Center(
                                child: Text(
                                  '+25% scores/turn',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: _queryData.size.height * .02),
                                ),
                              ),
                            ),
                            Container(
                              width: _queryData.size.width * .3,
                              height: _queryData.size.height * .1,
                              color: Colors.transparent,
                              child: Center(
                                child: Text(
                                  '-50% shop cost',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: _queryData.size.height * .02),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  //_isActiveAnimation = true;
                                  clan = Clan.Blue;
                                  //_board.initBoard(clan);
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: _queryData.size.width * .3,
                                    height: _queryData.size.height * .4,
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      'assets/layout/$B_flag.png',
                                    ),
                                  ),
                                  Opacity(
                                    opacity: clan == Clan.Blue ? 1.0 : 0.0,
                                    child: Container(
                                      width: _queryData.size.width * .3,
                                      height: _queryData.size.height * .38,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        'assets/layout/$Frame_flag.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  //_isActiveAnimation = true;
                                  clan = Clan.Red;
                                  //_board.initBoard(clan);
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: _queryData.size.width * .3,
                                    height: _queryData.size.height * .4,
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      'assets/layout/$R_flag.png',
                                    ),
                                  ),
                                  Opacity(
                                    opacity: clan == Clan.Red ? 1.0 : 0.0,
                                    child: Container(
                                      width: _queryData.size.width * .3,
                                      height: _queryData.size.height * .38,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        'assets/layout/$Frame_flag.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // _isActiveAnimation = true;
                                  clan = Clan.Green;
                                  // _board.initBoard(clan);
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: _queryData.size.width * .3,
                                    height: _queryData.size.height * .4,
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      'assets/layout/$G_flag.png',
                                    ),
                                  ),
                                  Opacity(
                                    opacity: clan == Clan.Green ? 1.0 : 0.0,
                                    child: Container(
                                      width: _queryData.size.width * .3,
                                      height: _queryData.size.height * .38,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        'assets/layout/$Frame_flag.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _queryData.size.height * .05,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isActiveAnimation = true;
                              _board.initBoard(clan);
                              playLocal();
                            });
                          },
                          child: Container(
                            width: _queryData.size.width * .5,
                            height: _queryData.size.height * .05,
                            color: Colors.green.shade300.withOpacity(.5),
                            child: Center(
                              child: Text(
                                'Play This Clan'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: _queryData.size.height * .017,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _queryData.size.height * .02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: _queryData.size.width * .5,
                            height: _queryData.size.height * .05,
                            color: Colors.green.shade300.withOpacity(.5),
                            child: Center(
                              child: Text(
                                'Return to Main Menu'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: _queryData.size.height * .017,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      gradient: clan == Clan.Red
                          ? bgGradientR
                          : clan == Clan.Blue
                              ? bgGradientB
                              : bgGradientG),
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
                                'assets/layout/${getHUD(HUD_topR, HUD_topB, HUD_topG)}.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
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
                                        'assets/layout/${getHUD(HUD_restart_button_R, HUD_restart_button_B, HUD_restart_button_G)}.png',
                                        width: _queryData.size.width * .2,
                                        fit: BoxFit.fitWidth,
                                      )),
                                ),
                                // Spacer(),
                                Container(
                                  height: _queryData.size.height * .19,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            _queryData.size.width * .02,
                                            _queryData.size.height * .019,
                                            _queryData.size.width * .02,
                                            0),
                                        child: Container(
                                          width: _queryData.size.width * .6,
                                          height: _queryData.size.height * .055,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        _queryData.size.width *
                                                            .015),
                                                child: Image.asset(
                                                  'assets/layout/coin.png',
                                                  width: _queryData.size.width *
                                                      .05,
                                                ),
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Icon(
                                              //       Icons.arrow_upward,
                                              //       size: _queryData.size.width * .04,
                                              //       color: Colors.green,
                                              //     ),
                                              //     Text(
                                              //       "${_board.value_change}",
                                              //       textAlign: TextAlign.right,
                                              //       style: TextStyle(
                                              //           color: Colors.white,
                                              //           fontSize:
                                              //               _queryData.size.height *
                                              //                   .015,
                                              //           fontWeight: FontWeight.bold),
                                              //     ),
                                              //   ],
                                              // ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        _queryData.size.width *
                                                            .04,
                                                    vertical:
                                                        _queryData.size.width *
                                                            .02),
                                                child: Row(
                                                  children: [
                                                    // FutureBuilder(
                                                    //     future: getData(),
                                                    //     builder: (context, snapshot) {
                                                    //       return snapshot.hasData
                                                    //           ? Text(
                                                    //               "${snapshot.data['scores']}",
                                                    //               textAlign:
                                                    //                   TextAlign.right,
                                                    //               style: TextStyle(
                                                    //                   color: Colors
                                                    //                       .white,
                                                    //                   fontSize: _queryData
                                                    //                           .size
                                                    //                           .height *
                                                    //                       .03,
                                                    //                   fontWeight:
                                                    //                       FontWeight
                                                    //                           .bold),
                                                    //             )
                                                    //           : CircularProgressIndicator();
                                                    //     }),
                                                    Text(
                                                      "${_board.scores.toStringAsFixed(0)}",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: _queryData
                                                                  .size.height *
                                                              .025,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: _queryData
                                                              .size.width *
                                                          .015,
                                                    ),
                                                    Text(
                                                      "${_board.point}",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: _queryData
                                                                  .size.height *
                                                              .015,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: _queryData.size.height *
                                                    .023),
                                            child: Text(
                                              " ${_board.skill_point}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize:
                                                      _queryData.size.height *
                                                          .02,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: _queryData.size.width * .1,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: _queryData.size.height *
                                                    .02,
                                                right: _queryData.size.width *
                                                    .007),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isPlayingMusic =
                                                      !_isPlayingMusic;
                                                });
                                                if (_isPlayingMusic) {
                                                  playLocal();
                                                } else
                                                  pauseLocal();
                                              },
                                              child: Container(
                                                width:
                                                    _queryData.size.width * .12,
                                                height:
                                                    _queryData.size.width * .12,
                                                child: Center(
                                                    child: Image.asset(
                                                        _isPlayingMusic
                                                            ? 'assets/layout/${getHUD(HUD_audioOn_button_R, HUD_audioOn_button_B, HUD_audioOn_button_G)}.png'
                                                            : 'assets/layout/${getHUD(HUD_audioOff_button_R, HUD_audioOff_button_B, HUD_audioOff_button_G)}.png',
                                                        width: _queryData
                                                                .size.width *
                                                            .085)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      !_gameOver
                          ? Flexible(
                              child: SizedBox(
                                height: _queryData.size.height > max_height
                                    ? (_queryData.size.width +
                                            (_queryData.size.height * .15) +
                                            (_queryData.size.width * .2)) /
                                        10
                                    : _queryData.size.width * .05,
                                child: _queryData.size.height > max_height ||
                                        _queryData.size.width < max_width
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                _queryData.size.width * .02),
                                        child: Container(
                                          child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: getTile(clan).length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: _queryData.size.width *
                                                      .25,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Image.asset(
                                                        'assets/monster/' +
                                                            getTile(clan)[
                                                                tileArray[
                                                                    index]] +
                                                            ".png",
                                                        width: _queryData
                                                                .size.width *
                                                            .08,
                                                      ),
                                                      Container(
                                                        width: _queryData
                                                                .size.width *
                                                            .1,
                                                        child: Text(
                                                          _board.cubeCount[
                                                                          index]
                                                                      .toString()
                                                                      .length <
                                                                  5
                                                              ? _board
                                                                  .cubeCount[
                                                                      index]
                                                                  .toString()
                                                              : _board.cubeCount[
                                                                          index]
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          3) +
                                                                  "M",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: _queryData
                                                                      .size
                                                                      .height *
                                                                  .015,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                            )
                          : SizedBox.shrink(),
                      !_gameOver
                          ? Container(
                              width: _queryData.size.width,
                              height: _queryData.size.width,
                              child: DragEvent(
                                children: children,
                                board: _board,
                                gameOver: GameOver,
                              ),
                            )
                          : GameOverWidget(
                              board: _board,
                              queryData: _queryData,
                            ),
                      Spacer(),
                      _queryData.size.height > max_height && !_gameOver
                          ? Flexible(
                              child: Container(
                                width: _queryData.size.width,
                                height: _queryData.size.height * .065,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {});
                                        if ((buy_index + 1) <
                                                getDexData().length &&
                                            (buy_index + 1) > 1) {
                                          buy_index--;
                                        }
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: _queryData.size.height * .05,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      width: _queryData.size.width * .7,
                                      height: _queryData.size.height * .065,
                                      decoration: BoxDecoration(
                                          color: Colors.white38,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: buy_index < getDexData().length
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _board.activeValue(
                                                          buy_index);
                                                    });
                                                  },
                                                  child: Container(
                                                    width: getSubtringValue(
                                                                    (buy_index +
                                                                        1),
                                                                    _board
                                                                        .discout)
                                                                .toStringAsFixed(
                                                                    0)
                                                                .length <
                                                            6
                                                        ? _queryData
                                                                .size.width *
                                                            .2
                                                        : _queryData
                                                                .size.width *
                                                            .25,
                                                    height:
                                                        _queryData.size.height *
                                                            .035,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white38,
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Container(
                                                        width: getSubtringValue(
                                                                        (buy_index +
                                                                            1),
                                                                        _board
                                                                            .discout)
                                                                    .toStringAsFixed(
                                                                        0)
                                                                    .length <
                                                                6
                                                            ? _queryData.size
                                                                    .width *
                                                                .20
                                                            : _queryData.size
                                                                    .width *
                                                                .25,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Image.asset(
                                                              'assets/layout/coin.png',
                                                              width: _queryData
                                                                      .size
                                                                      .width *
                                                                  .05,
                                                            ),
                                                            Text(
                                                              '${(getSubtringValue(buy_index + 1, _board.discout).toStringAsFixed(0))}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: getSubtringValue(buy_index + 1, _board.discout)
                                                                            .toStringAsFixed(
                                                                                0)
                                                                            .length <
                                                                        6
                                                                    ? _queryData
                                                                            .size
                                                                            .height *
                                                                        .02
                                                                    : _queryData
                                                                            .size
                                                                            .height *
                                                                        .015,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Colors.orange
                                                                    .shade100,
                                                            scrollable: true,
                                                            content: Container(
                                                              width: _queryData
                                                                  .size.width,
                                                              height: _queryData
                                                                      .size
                                                                      .height *
                                                                  .4,
                                                              child: GridView
                                                                  .builder(
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      itemCount:
                                                                          getTile(clan).length -
                                                                              1,
                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              5,
                                                                          mainAxisSpacing:
                                                                              5,
                                                                          crossAxisSpacing:
                                                                              5),
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              buy_index = index;
                                                                              Navigator.pop(context);
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                _queryData.size.width * .1,
                                                                            height:
                                                                                _queryData.size.width * .1,
                                                                            child:
                                                                                Image.asset('assets/monster/' + getTile(clan)[tileArray[index + 1]] + ".png", width: _queryData.size.width * .1),
                                                                          ),
                                                                        );
                                                                      }),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Image.asset(
                                                    'assets/monster/' +
                                                        getTile(clan)[tileArray[
                                                            buy_index + 1]] +
                                                        ".png",
                                                    width:
                                                        _queryData.size.width *
                                                            .1,
                                                    height:
                                                        _queryData.size.height *
                                                            .1,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _board.activeTradeValue(
                                                          buy_index);
                                                    });
                                                  },
                                                  child: Container(
                                                    width:
                                                        _queryData.size.width *
                                                            .2,
                                                    height:
                                                        _queryData.size.height *
                                                            .035,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white38,
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Container(
                                                        width: _queryData
                                                                .size.width *
                                                            .2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Image.asset(
                                                              'assets/monster/' +
                                                                  getTile(clan)[
                                                                      tileArray[
                                                                          buy_index]] +
                                                                  ".png",
                                                              width: _queryData
                                                                      .size
                                                                      .width *
                                                                  .05,
                                                            ),
                                                            Text(
                                                              '${(trade_cost / _board.discout).toStringAsFixed(0)}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: _queryData
                                                                        .size
                                                                        .height *
                                                                    .02,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox.shrink(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if ((buy_index + 1) <
                                              getDexData().length - 1) {
                                            buy_index++;
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: _queryData.size.height * .05,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: _queryData.size.height * .01,
                      ),
                      Container(
                        width: _queryData.size.width,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/layout/${getHUD(HUD_bottomR, HUD_bottomB, HUD_bottomG)}.png',
                                width: _queryData.size.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: _queryData.size.height * .005),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: _queryData.size.width * .026,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return MessageBox(
                                              text:
                                                  "Trở về màn hình chính? (Toàn bộ tiến trình sẽ không được lưu)",
                                              onPress: () {
                                                pauseLocal();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            );
                                          });
                                    },
                                    child: Container(
                                      width: _queryData.size.width * .15,
                                      height: _queryData.size.width * .2,
                                      child: Center(
                                          child: Image.asset(
                                        'assets/layout/${getHUD(HUD_return_button_R, HUD_return_button_B, HUD_return_button_G)}.png',
                                        width: _queryData.size.width * .1,
                                        fit: BoxFit.fitWidth,
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _queryData.size.width * .027,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isMonster = true;
                                      });
                                      _key.currentState.openDrawer();
                                    },
                                    child: Container(
                                      width: _queryData.size.width * .14,
                                      height: _queryData.size.width * .2,
                                      child: Center(
                                          child: Image.asset(
                                        'assets/layout/${getHUD(HUD_mon_button_R, HUD_mon_button_B, HUD_mon_button_G)}.png',
                                        width: _queryData.size.width * .13,
                                        fit: BoxFit.fitWidth,
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _queryData.size.width * .027,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isMonster = false;
                                      });

                                      _key.currentState.openDrawer();
                                    },
                                    child: Container(
                                      width: _queryData.size.width * .24,
                                      height: _queryData.size.height * .1,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => FormulaPage(
                                                    board: _board,
                                                    clan: clan,
                                                  )));
                                    },
                                    child: Container(
                                      width: _queryData.size.width * .14,
                                      height: _queryData.size.width * .2,
                                      child: Center(
                                          child: Image.asset(
                                        'assets/layout/${getHUD(HUD_fx_button_R, HUD_fx_button_B, HUD_fx_button_G)}.png',
                                        fit: BoxFit.fitWidth,
                                        width: _queryData.size.width * .13,
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _queryData.size.width * .032,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DexPage(
                                                    clan: clan,
                                                  )));
                                    },
                                    child: Container(
                                      width: _queryData.size.width * .14,
                                      height: _queryData.size.width * .2,
                                      child: Center(
                                          child: Image.asset(
                                              'assets/layout/${getHUD(HUD_dex_button_R, HUD_dex_button_B, HUD_dex_button_G)}.png',
                                              fit: BoxFit.fitWidth,
                                              width:
                                                  _queryData.size.width * .1)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _queryData.size.width * .03,
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
      ),
    );
  }

  String ConvertShortCutValue(int scores) {
    if (scores >= 100000 && scores < 1000000) {
      return scores.toStringAsFixed(1).toString().substring(0, 3) + "K";
    } else if (scores >= 1000000) {
      return scores.toString().substring(0, 1) +
          "." +
          scores.toString().substring(1, 2) +
          "M";
    } else {
      return scores.toString();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

Map<int, String> getTile(Clan clan) {
  if (clan == Clan.Blue) {
    return tileBlue;
  }
  if (clan == Clan.Green) {
    return tileGreen;
  }
  if (clan == Clan.Red) {
    return tileRed;
  }
}

class AnimatedTileWidget extends AnimatedWidget {
  final Tile tile;
  final _BoardWidgetState state;
  final Clan clan;

  AnimatedTileWidget(
      {Key key, this.tile, this.state, this.clan, Animation<double> animation})
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
        image: getTile(clan).containsKey(tile.value)
            ? getTile(clan)[tile.value]
            : "",
      );
    }
  }
}

class TileWidget extends StatefulWidget {
  final Tile tile;
  final _BoardWidgetState state;
  final Clan clan;

  const TileWidget({Key key, this.tile, this.state, this.clan})
      : super(key: key);

  @override
  _TileWidgetState createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget>
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
    return AnimatedTileWidget(
      tile: widget.tile,
      state: widget.state,
      clan: widget.clan,
      animation: animation,
    );
  }
}
