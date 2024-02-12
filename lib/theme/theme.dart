import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2394C1)),
    fontFamily: 'Roboto',
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      filled: true,
      fillColor:
          Colors.white, // Change to desired background color for text fields
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
