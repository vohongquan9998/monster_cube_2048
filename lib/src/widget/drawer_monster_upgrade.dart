import 'package:flutter/material.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';
import 'package:flutter_2048_program_language/src/utils/dex_data.dart';
import 'package:flutter_2048_program_language/src/utils/item_data.dart';

class Drawer_Monster_Upgrade extends StatefulWidget {
  final Board board;
  final MediaQueryData queryData;

  const Drawer_Monster_Upgrade({Key key, this.board, this.queryData})
      : super(key: key);

  @override
  State<Drawer_Monster_Upgrade> createState() => _Drawer_Monster_UpgradeState();
}

class _Drawer_Monster_UpgradeState extends State<Drawer_Monster_Upgrade> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: widget.queryData.size.width * .8,
          height: widget.queryData.size.height * .05,
          child: Text(
            'Nâng cấp quái vật lượt tiếp theo sẽ cộng thêm điểm cho bạn',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.queryData.size.height * .015,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          width: widget.queryData.size.width * .8,
          height: widget.queryData.size.height * .05,
          child: Text(
            'Điểm thành thạo: ${widget.board.skill_point} \n Phần trăm tăng : ${widget.board.percent.toStringAsFixed(1)}%',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.queryData.size.height * .02,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          width: widget.queryData.size.width,
          height: widget.queryData.size.height * .8,
          child: ListView.builder(
              itemCount: getDexData().length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: widget.board.skill_point < getDexData()[index].value
                      ? EdgeInsets.all(0.0)
                      : EdgeInsets.symmetric(
                          vertical: widget.queryData.size.width * .02),
                  child: Stack(
                    children: [
                      Container(
                        height: widget.queryData.size.height * .15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: widget.queryData.size.width * .03,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/monster/" +
                                      getDexData()[index].image +
                                      ".png",
                                  width: widget.queryData.size.width * .1,
                                ),
                                SizedBox(
                                  height: widget.queryData.size.height * .01,
                                ),
                                Container(
                                  width: widget.queryData.size.width * .3,
                                  child: Text(
                                    '${getDexData()[index].name}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize:
                                          widget.queryData.size.height * .015,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.board.skill_point >=
                                      getDexData()[index].value) {
                                    widget.board.checkSkillPoint(index);
                                  }
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widget.queryData.size.width * .3,
                                    height: widget.queryData.size.height * .05,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: widget.queryData.size.width *
                                                .1,
                                            child: Text(
                                              'lv:${widget.board.lv[index]}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: widget
                                                        .queryData.size.height *
                                                    .02,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widget.queryData.size.width *
                                                .15,
                                            child: Text(
                                              '${getDexData()[index].value}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: widget
                                                        .queryData.size.height *
                                                    .02,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: widget.queryData.size.height * .01,
                                  ),
                                  Container(
                                    width: widget.queryData.size.width * .2,
                                    child: Text(
                                      '+ ${(getDexData()[index].percent)}%',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize:
                                            widget.queryData.size.height * .015,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.board.skill_point < getDexData()[index].value
                          ? Container(
                              height: widget.queryData.size.height * .15,
                              color: Colors.black38,
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
