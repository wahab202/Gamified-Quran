import 'package:flutter/material.dart';
import 'DashBoard.dart';
import 'package:gamifiedquran/SharedPrefManager.dart';
import 'package:gamifiedquran/RegisterScreen.dart';
import 'package:gamifiedquran/SplashScreen.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPrefManager prefManager;
  Widget homeWidget = SplashScreen();

  void setHomeWidget() async {
    bool isFirstLaunch = await prefManager.isFirstLaunch();
    Timer timer = new Timer(new Duration(seconds: 5), ()
    {
      setState(() {
        if (isFirstLaunch) {
          homeWidget = RegisterScreen();
        } else {
          homeWidget = DashBoard();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    prefManager = SharedPrefManager();
    setHomeWidget();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Gamified Quran',
      home: homeWidget,
    );
  }
}
