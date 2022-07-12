import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';
import 'package:flutter_2048_program_language/src/utils/dex_data.dart';
import 'package:flutter_2048_program_language/src/utils/utils.dart';

class DexPage extends StatelessWidget {
  final Clan clan;

  const DexPage({Key key, this.clan}) : super(key: key);

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
        actions: [],
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
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .02, vertical: size.height * .01),
            child: Container(
                width: size.width,
                height: size.height,
                child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: getTile(clan).length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  elevation: 0,
                                  scrollable: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 24, 10, 24),
                                  backgroundColor: Colors.transparent,
                                  content: Container(
                                    width: size.width * .7,
                                    height: size.height * .5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.transparent),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/monster/' +
                                              getTile(clan)[tileArray[index]] +
                                              ".png",
                                          width: size.width * .7,
                                        ),
                                        // Container(
                                        //   width: size.width * .4,
                                        //   child: Text(
                                        //     getDexData()[index].name,
                                        //     textAlign: TextAlign.center,
                                        //     style: TextStyle(
                                        //         color: Colors.white,
                                        //         fontSize: size.height * .035,
                                        //         fontWeight: FontWeight.w500),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: size.width * .35,
                          height: size.height * .3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset('assets/monster/' +
                              getTile(clan)[tileArray[index]] +
                              ".png"),
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
