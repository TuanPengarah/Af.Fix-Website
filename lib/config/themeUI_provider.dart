import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.teal,
    colorScheme: ColorScheme.dark(),
    textTheme: TextTheme(
      headline1: TextStyle(color: kColorWhite),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: kColorWhite,
    primaryColor: Colors.red,
    colorScheme: ColorScheme.light(),
    textTheme: TextTheme(
      headline1: TextStyle(color: kColorWhite),
    ),
  );
}
