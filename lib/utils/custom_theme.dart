// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomTheme {
  static const Color grey = Color(0xffDFDFDF);
  static const Color red = Color(0xffDC143C);
  static const cardShadow = [
    BoxShadow(color: grey, blurRadius: 6, spreadRadius: 4, offset: Offset(0, 2))
  ];
  static const buttonShadow = [
    BoxShadow(color: grey, blurRadius: 3, spreadRadius: 4, offset: Offset(1, 2))
  ];

  static getCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: cardShadow,
    );
  }

  static ThemeData getTheme() {
    Map<String, double> fontSize = {
      "sm": 14,
      "md": 18,
      "lg": 24,
    };

    return ThemeData(
        primaryColor: red,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            toolbarHeight: 70,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: fontSize['lg'],
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            )),
        tabBarTheme: const TabBarTheme(
            labelColor: red, unselectedLabelColor: Colors.black),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: Colors.black,
              fontSize: fontSize['lg'],
              fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              color: Colors.black,
              fontSize: fontSize['md'],
              fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(
              color: Colors.black,
              fontSize: fontSize['sm'],
              fontWeight: FontWeight.bold),
          bodySmall: TextStyle(
              fontSize: fontSize['sm'], fontWeight: FontWeight.normal),
          titleSmall: TextStyle(
              fontSize: fontSize['sm'],
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.white),
        ));
  }
}
