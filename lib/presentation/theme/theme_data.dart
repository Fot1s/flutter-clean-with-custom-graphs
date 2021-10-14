import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get mainTheme {
    return ThemeData( //2
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400),
          headline2: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          headline3: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          headline4: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          subtitle1: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.normal)
        )
    );
  }
}