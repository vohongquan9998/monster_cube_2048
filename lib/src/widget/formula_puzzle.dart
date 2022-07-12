import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/utils/dex_data.dart';
import 'package:flutter_2048_program_language/src/utils/utils.dart';

class Formula_Puzzle_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [],
        centerTitle: true,
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
                  height: size.height,
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
                                            getDexData()[index].image +
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
                                            getDexData()[index].image +
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
                                                  getDexData()[index + 1]
                                                      .image +
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
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: getDexData().length - 1,
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
