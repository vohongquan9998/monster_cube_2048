import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2048_program_language/src/formula_page.dart';
import 'package:flutter_2048_program_language/src/homepage.dart';
import 'package:flutter_2048_program_language/src/main_menu.dart';
import 'package:flutter_2048_program_language/src/model/board.dart';

import 'package:splashscreen/splashscreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.brown.shade800, // navigation bar color
    statusBarColor:
        Colors.brown.shade800, // status bar color color of navigation controls
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => SafeArea(
              child: LoadingScreen(),
            ),
        '/formula': (context) => FormulaPage(),
      },
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = false;
  void loading() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/layout/logo_splash.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    left: MediaQuery.of(context).size.width * .25,
                    right: MediaQuery.of(context).size.width * .25,
                    bottom: MediaQuery.of(context).size.height * .05,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: Colors.transparent,
                    ))
              ],
            ))
        : MainMenu();
  }
}
