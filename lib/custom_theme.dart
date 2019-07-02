import 'package:flutter/material.dart';

final themeData = ThemeData(
  primarySwatch: Colors.pink,
  primaryIconTheme: IconThemeData(
    color: Colors.white70
  ),
  primaryTextTheme: TextTheme(
    title: TextStyle(
      color: Colors.white70
    ),
    body1: TextStyle(
      color: Colors.white
    )
  ),
  cardTheme: CardTheme(
    elevation: 2.5,
    color: Color.fromRGBO(90, 119, 153, 1.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
  )
);
