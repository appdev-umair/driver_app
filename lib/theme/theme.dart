import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2394C1)),
    fontFamily: 'Roboto',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        // Use OutlineInputBorder
        borderRadius: BorderRadius.circular(8.0), // Customize rounding
        borderSide: BorderSide(
          color: Color(0xFF2394C1), // Set border color
          width: 1.0, // Adjust border width
        ),
      ),
      enabledBorder: OutlineInputBorder(
        // Optional: customize enabled state
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Color(0xFF2394C1), // Lighter border for enabled state
        ),
      ),
      focusedBorder: OutlineInputBorder(
        // Optional: customize enabled state
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Color(0xFF2394C1), // Lighter border for enabled state
        ),
      ),
      errorBorder: OutlineInputBorder(
        // Customize error state
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.redAccent, // Red border for errors
          width: 1.5, // Slightly thicker border for errors
        ),
      ),
    ),
  );
}
