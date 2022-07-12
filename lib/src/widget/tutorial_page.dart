import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  List<String> title = [
    "Vuốt 4 hướng(LTRB) để duy chuyển khối vuông",
    "Thanh công cụ phía trên",
    "Thanh công cụ phía dưới"
  ];
  final List<String> image;

  TutorialPage({Key key, this.image}) : super(key: key);

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
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * .07),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * .05,
                        child: Text(
                          title[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * .02),
                        ),
                      ),
                      Container(
                        width: size.width * .8,
                        height: size.height * .4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/layout/' + image[index] + ".png",
                            width: size.width,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: image.length,
            ),
          ),
        ],
      ),
    );
  }
}
