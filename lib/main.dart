import 'package:flutter/material.dart';
import 'package:surfing_sns/screen/home_screen.dart';
import 'package:surfing_sns/style.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Namido",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.white30,
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        fontFamily: RegularFont,
      ),
      home: HomeScreen(),
    );
  }
}
