import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/puzzle.dart';
import 'package:flutter_2048_program_language/src/puzzle_page.dart';
import 'package:flutter_2048_program_language/src/utils/dex_data.dart';
import 'package:flutter_2048_program_language/src/utils/utils.dart';

class Puzzle_Choose_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            width: size.width,
            height: size.height,
            child: Image.asset(
              'assets/layout/old_paper.png',
              fit: BoxFit.fitHeight,
            ),
          )),
          Padding(
            padding: EdgeInsets.all(size.height * .02),
            child: Container(
                width: size.width,
                height: size.height,
                child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: getListPuzzle().length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: size.width * .04,
                        crossAxisSpacing: size.width * .04),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Puzzle_Page(index: index)));
                        },
                        child: Container(
                          width: size.width * .15,
                          height: size.height * .3,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                    'assets/layout/${getListPuzzle()[index].image}.png',
                                    width: size.width * .05),
                              ),
                              Positioned(
                                top: size.height * .05,
                                left: size.width * .05,
                                right: size.width * .05,
                                child: Container(
                                  width: size.width * .05,
                                  color: Colors.transparent,
                                  child: Text(
                                    (getListPuzzle()[index].id + 1).toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: size.height * .025,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          ),
          // ),
          // child: ListView.builder(
          //     itemCount: getListPuzzle().length,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         width: size.width * .35,
          //         height: size.height * .2,
          //         child: Stack(
          //           children: [
          //             Positioned.fill(
          //               child: Image.asset(
          //                 'assets/layout/${getListPuzzle()[index].image}.png',
          //                 width: size.width * .05,
          //                 fit: BoxFit.fitHeight,
          //               ),
          //             ),
          //             Positioned(
          //               top: size.height * .05,
          //               left: size.width * .35,
          //               right: size.width * .35,
          //               child: GestureDetector(
          //                 onTap: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (_) =>
          //                               Puzzle_Page(index: index)));
          //                 },
          //                 child: Container(
          //                   width: size.width * .05,
          //                   height: size.height * .15,
          //                   color: Colors.transparent,
          //                   child: Center(
          //                     child: Text(
          //                       (getListPuzzle()[index].id + 1).toString(),
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontSize: size.height * .04,
          //                           color: Colors.white),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     }),
          //),
        ],
      ),
    );
  }
}
