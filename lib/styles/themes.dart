import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme = ThemeData(
  textTheme: const TextTheme(
    headline6: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
  ),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepOrange,
    elevation: 3.0,
    // so we can change theme of  the status bar
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Colors.white,
      // statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 20.0,
      selectedItemColor: Colors.deepOrange),
  primarySwatch: Colors.deepOrange,
);
