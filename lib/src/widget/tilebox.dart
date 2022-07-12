import 'package:flutter/material.dart';

class TileBox extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final String image;

  const TileBox({Key key, this.left, this.top, this.size, this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: image != ""
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('assets/monster/' + image + ".png"))
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
