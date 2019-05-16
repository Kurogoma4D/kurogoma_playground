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
  ),
  cardTheme: CardTheme(
    elevation: 2.5,
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
  )
);
