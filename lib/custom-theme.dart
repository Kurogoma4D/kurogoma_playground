import 'package:flutter/material.dart';

final themeData = ThemeData(
  primarySwatch: Colors.pink,
  primaryIconTheme: IconThemeData(
    color: Colors.black87
  ),
  primaryTextTheme: TextTheme(
    title: TextStyle(
      color: Colors.black
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2.5,
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
  )
);
