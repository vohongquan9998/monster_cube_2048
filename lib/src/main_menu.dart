import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/homepage.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';
import 'package:flutter_2048_program_language/src/model/puzzle_board.dart';
import 'package:flutter_2048_program_language/src/puzzle_choose_page.dart';
import 'package:flutter_2048_program_language/src/puzzle_page.dart';
import 'package:flutter_2048_program_language/src/utils/dex_data.dart';
import 'package:flutter_2048_program_language/src/utils/utils.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/layout/banner_2048.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
                top: size.height * .36,
                bottom: size.height * .3,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BoardWidget(),
                            ));
                      },
                      child: Container(
                        width: size.width,
                        height: size.height * .13,
                        color: Colors.transparent,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Puzzle_Choose_Page(),
                            ));
                      },
                      child: Container(
                        width: size.width,
                        height: size.height * .13,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                )),
            Positioned(
              top: size.height * .01,
              right: 0,
              child: Container(
                width: size.width,
                height: size.height * .05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        iconSize: size.width * .05,
                        icon: Icon(
                          Icons.warning,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext contex) {
                                return AlertDialog(
                                  content: Container(
                                    height: size.height * .4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: size.width * .6,
                                          child: Text(
                                            "Cảm ơn bạn đã dùng thử phiên bản thử nghiệm của trò chơi Monster Cube 2048",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * .01,
                                        ),
                                        Container(
                                          width: size.width * .6,
                                          child: Text(
                                            "Phiên bản : ${version}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: size.height * .02,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * .01,
                                        ),
                                        Container(
                                          width: size.width * .6,
                                          child: Text(
                                            "Được thiết kế & phát triển bởi \n\n Võ Hồng Quân",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: size.height * .02,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * .01,
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Container(
                                    width: size.width * .3,
                                    child: Text(
                                      "Monster Cube 2048",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              });
                        }),
                    SizedBox(
                      width: size.width * .06,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
