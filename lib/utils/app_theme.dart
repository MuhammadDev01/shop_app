import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData defaultTheme = ThemeData(
  primarySwatch: defaultColor,
  fontFamily: 'REM',
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    actionsIconTheme: IconThemeData(
      color: defaultColor,
      size: 24,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 32,
    ),
  ),
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
    elevation: 20.0,
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  fontFamily: 'REM',
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    backgroundColor: Color(0xff27292a),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff27292a),
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 32,
    ),
  ),
  scaffoldBackgroundColor: const Color(0xff27292a),
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xff27292a),
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,
    elevation: 20.0,
  ),
);

const  defaultColor = Colors.cyan;
