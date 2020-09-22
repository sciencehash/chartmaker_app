import 'package:flutter/material.dart';
import '../no_transitions_on_web.dart';

class DarkTheme {
  static get themeData => ThemeData(
    pageTransitionsTheme: NoTransitionsOnWeb(),
    fontFamily: 'Ubuntu-Light',
    brightness: Brightness.dark,
    primaryColor: Color(0xFF00a3cc),
    accentColor: Color(0xFF00b5e3),
    scaffoldBackgroundColor: Color(0xff272b34),
    appBarTheme: AppBarTheme(
      elevation: .5,
      brightness: Brightness.dark,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 21,
        ),
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Color(0xff2d343e),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF00a3cc),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00a3cc),
      foregroundColor: Colors.white,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xff2c333d),
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(
        height: 1.3,
        fontSize: 15,
        color: Colors.black,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Color(0xff2C333D),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xff272b34),
    ),
  );
}