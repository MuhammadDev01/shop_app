import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/utils/app_style.dart';

ThemeData defaultTheme(BuildContext context) => ThemeData(
      primarySwatch: defaultColor,
      brightness: Brightness.light,
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
      textTheme: TextTheme(
        titleLarge: AppStyle.style30Semibold(context),
        titleMedium: AppStyle.style24Medium(context),
        titleSmall: AppStyle.style18Medium(context),
      ),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: defaultColor,
        elevation: 20.0,
      ),
    );

ThemeData darkTheme(BuildContext context) => ThemeData(
      scaffoldBackgroundColor: const Color(0xff27292a),
      primarySwatch: defaultColor,
      brightness: Brightness.dark,
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
      textTheme: TextTheme(
        titleLarge: AppStyle.style30Semibold(context).copyWith(
          color: Colors.white,
        ),
        titleMedium: AppStyle.style24Medium(context),
        titleSmall: AppStyle.style18Medium(context),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff27292a),
        unselectedItemColor: Colors.grey,
        selectedItemColor: defaultColor,
        elevation: 20.0,
      ),
    );

const defaultColor = Colors.cyan;
