import 'package:flutter/material.dart';

import 'globals.dart';
import 'transitions.dart';

class OMITheme {
  static ThemeData lightTheme() {
    // Define your theme properties here
    return ThemeData(
      scaffoldBackgroundColor: Colors.grey[200], // Grey background
      appBarTheme: const AppBarTheme(
        backgroundColor: Globals.primaryColor,
        elevation: 10,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.green, // Green button background
        textTheme: ButtonTextTheme.primary,
      ),
      iconButtonTheme: const IconButtonThemeData(),
      primaryTextTheme: const TextTheme(
          titleMedium: TextStyle(fontFamily: "Lato"),
          displayLarge: TextStyle(fontFamily: "Roboto")),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
            fontFamily: "Lato", fontWeight: FontWeight.bold), // Bolder ListTile
      ),
      // other properties...
    );
  }

  static ThemeData darkTheme() {
    // Define your dark theme properties here
    return ThemeData.dark().copyWith(
      primaryColor: Colors.deepPurple,
      // other properties...
    );
  }
}
