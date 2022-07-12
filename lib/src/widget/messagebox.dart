import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String text;
  final Function onPress;

  const MessageBox({Key key, this.text, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 24, 0, 24),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/layout/icon_2048_dialog.png',
              width: size.width,
            ),
          ),
          Container(
            width: size.width,
            height: size.height * .25,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * .6,
                  height: size.height * .1,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: size.height * .018),
                  ),
                ),
                SizedBox(
                  height: size.height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onPress();
                      },
                      child: Image.asset(
                        'assets/layout/icon_2048_accect.png',
                        width: size.width * .15,
                      ),
                    ),
                    SizedBox(
                      width: size.width * .2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/layout/icon_2048_close.png',
                        width: size.width * .15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
