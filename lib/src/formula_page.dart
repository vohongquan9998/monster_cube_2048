import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';
import 'package:flutter_2048_program_language/src/utils/dex_data.dart';
import 'package:flutter_2048_program_language/src/utils/utils.dart';
import 'package:flutter_2048_program_language/src/widget/tutorial_page.dart';

class FormulaPage extends StatefulWidget {
  final Board board;
  final Clan clan;
  const FormulaPage({Key key, this.board, this.clan}) : super(key: key);

  @override
  _FormulaPageState createState() => _FormulaPageState();
}

class _FormulaPageState extends State<FormulaPage> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TutorialPage(
                              image: [
                                tutorial1,
                                tutorial2,
                                tutorial3,
                              ],
                            )));
              },
              child: Icon(Icons.contact_support_rounded))
        ],
        centerTitle: true,
        title: Opacity(
          opacity: size.height < max_height ? 1.0 : 0.0,
          child: Container(
            width: size.width * .5,
            decoration: BoxDecoration(
                color: Colors.white60, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/layout/coin.png',
                  width: size.width * .05,
                ),
                SizedBox(
                  width: size.width * .01,
                ),
                Text(widget.board.scores.toStringAsFixed(0),
                    style: TextStyle(
                        color: Colors.black, fontSize: size.height * .03)),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/layout/old_paper.png',
            fit: BoxFit.fitHeight,
          )),
          Container(
            decoration: BoxDecoration(
                color: Colors.white38, borderRadius: BorderRadius.circular(15)),
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Container(
                  height: size.height * .9,
                  width: size.width,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(size.width * .01),
                        child: Container(
                          height: size.height < max_height
                              ? size.height * .2
                              : size.height * .15,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/monster/' +
                                            getTile(
                                                widget.clan)[tileArray[index]] +
                                            ".png",
                                        width: size.width * .15,
                                      ),
                                      SizedBox(
                                        height: size.height * .015,
                                      ),
                                      Text(
                                        '${tileArray[index]}',
                                        style: TextStyle(
                                            fontSize: size.height * .015),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '+',
                                    style:
                                        TextStyle(fontSize: size.height * .04),
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/monster/' +
                                            getTile(
                                                widget.clan)[tileArray[index]] +
                                            ".png",
                                        width: size.width * .15,
                                      ),
                                      SizedBox(
                                        height: size.height * .015,
                                      ),
                                      Text(
                                        '${tileArray[index]}',
                                        style: TextStyle(
                                            fontSize: size.height * .015),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '=',
                                    style:
                                        TextStyle(fontSize: size.height * .04),
                                  ),
                                  index < getDexData().length
                                      ? Column(
                                          children: [
                                            Image.asset(
                                              'assets/monster/' +
                                                  getTile(widget.clan)[
                                                      tileArray[index + 1]] +
                                                  ".png",
                                              width: size.width * .15,
                                            ),
                                            SizedBox(
                                              height: size.height * .015,
                                            ),
                                            Text(
                                              '${tileArray[index + 1]}',
                                              style: TextStyle(
                                                  fontSize: size.height * .015),
                                            )
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                height: size.height * .015,
                              ),
                              // widget.board.isEmpty
                              //     ? Container(
                              //         width: size.width * .4,
                              //         child: Text(
                              //           "Not enough space to buy new monster!",
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             fontSize: size.height * .02,
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.black87,
                              //           ),
                              //         ),
                              //       )
                              //     : SizedBox.shrink(),
                              // SizedBox(
                              //   height: size.height * .015,
                              // ),
                              size.height < max_height
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.board.activeValue(index);
                                            });
                                          },
                                          child: Container(
                                            width: size.width * .4,
                                            height: size.height * .05,
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
                                                width: size.width * .3,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Image.asset(
                                                      'assets/layout/coin.png',
                                                      width: size.width * .05,
                                                    ),
                                                    Text(
                                                      '${(getSubtringValue(index + 1, widget.board.discout).toStringAsFixed(0))}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.height * .02,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87,
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
                                            setState(() {
                                              widget.board
                                                  .activeTradeValue(index);
                                            });
                                          },
                                          child: Container(
                                            width: size.width * .4,
                                            height: size.height * .05,
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
                                                width: size.width * .3,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Image.asset(
                                                      'assets/monster/' +
                                                          getTile(widget.clan)[
                                                              tileArray[
                                                                  index]] +
                                                          ".png",
                                                      width: size.width * .05,
                                                    ),
                                                    Text(
                                                      '${trade_cost}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.height * .02,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87,
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
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: getTile(widget.clan).length - 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                  child: Container(
                    height: size.height * .1,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: getTile(widget.clan).length - 1,
                        itemBuilder: (context, index) {
                          return Container(
                            width: size.width * .25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/monster/' +
                                      getTile(widget.clan)[tileArray[index]] +
                                      ".png",
                                  width: size.width * .08,
                                ),
                                Container(
                                  width: size.width * .1,
                                  child: Text(
                                    widget.board.cubeCount[index]
                                                .toString()
                                                .length <
                                            5
                                        ? widget.board.cubeCount[index]
                                            .toString()
                                        : widget.board.cubeCount[index]
                                                .toString()
                                                .substring(0, 3) +
                                            "M",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.height * .015,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
