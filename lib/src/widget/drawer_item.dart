import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';
import 'package:flutter_2048_program_language/src/utils/item_data.dart';

class Drawer_Items extends StatelessWidget {
  final Board board;
  final MediaQueryData queryData;

  const Drawer_Items({Key key, this.board, this.queryData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: queryData.size.width,
          height: queryData.size.height * .05,
          child: Text(
            'Khi số điểm của bạn đạt đến mức nhất định bạn sẽ nhận thêm điểm cộng / mỗi lượt (Không cộng dồn)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: queryData.size.height * .015,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          width: queryData.size.width * .8,
          height: queryData.size.height * .05,
          child: Text(
            'Điểm: ${board.scores.toStringAsFixed(0)} \n Điểm cộng : ${board.point} point',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: queryData.size.height * .02,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          width: queryData.size.width,
          height: queryData.size.height * .8,
          child: ListView.builder(
              itemCount: getItemData().length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(queryData.size.width * .02),
                  child: Stack(
                    children: [
                      Container(
                        height: queryData.size.height * .15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: queryData.size.width * .15,
                              child: Text(
                                '${getItemData()[index].value}',
                                style: TextStyle(
                                  fontSize: queryData.size.height * .02,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: queryData.size.width * .03,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            content: Container(
                                              color: Colors.transparent,
                                              width: queryData.size.width * .25,
                                              height:
                                                  queryData.size.height * .25,
                                              child: Image.asset(
                                                "assets/items/2048_item_" +
                                                    getItemData()[index].image +
                                                    ".png",
                                                width:
                                                    queryData.size.width * .25,
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Image.asset(
                                    "assets/items/2048_item_" +
                                        getItemData()[index].image +
                                        ".png",
                                    width: queryData.size.width * .1,
                                  ),
                                ),
                                SizedBox(
                                  height: queryData.size.height * .01,
                                ),
                                Container(
                                  width: queryData.size.width * .3,
                                  child: Text(
                                    '${getItemData()[index].name}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: queryData.size.height * .015,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: queryData.size.width * .15,
                              child: Text(
                                '${getItemData()[index].point} point',
                                style: TextStyle(
                                  fontSize: queryData.size.height * .02,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      board.scores >= getItemData()[index].value
                          ? Positioned(
                              left: 0,
                              top: queryData.size.height * .03,
                              child: Opacity(
                                opacity: .6,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.green)),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: queryData.size.height * .08,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
