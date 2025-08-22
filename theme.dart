import 'package:flutter/material.dart';

ThemeData buildErythraTheme() {
  const primary = Color(0xFFD00000); // Erythra red
  const background = Color(0xFFFFFFFF);

  return ThemeData(
    primaryColor: primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primary,
      secondary: Colors.grey[600],
      background: background,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14.0),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
