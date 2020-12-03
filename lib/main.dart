import 'package:flutter/material.dart';
import 'package:hos/expense_report/expense_report.dart';
import 'package:hos/outstanding_report/outingstang_report.dart';
import 'package:hos/pagging.dart';
import 'package:hos/sale_report/detaillist.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:splash_screen_view/ColorizeAnimatedText.dart';
import 'package:splash_screen_view/ScaleAnimatedText.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:splash_screen_view/TyperAnimatedText.dart';

import 'dashboard.dart';
import 'login/login.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// Logo with animated Colorize text
  final example2 = SplashScreenView(
    home:   Dashboard(),
    duration: 10000,
    imageSize: 100,
    imageSrc: "assets/images/hos_logo.png",
    text: "House of solution",
    textType: TextType.ColorizeAnimationText,
    textStyle: TextStyle(
      fontSize: 25.0,
    ),
    colors: [
      Colors.purple,
      Colors.green,
      Colors.yellow,
      Colors.red,
    ],
    backgroundColor: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash screen Demo',
      home: example2,
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.green
      ),
    );
  }
}
