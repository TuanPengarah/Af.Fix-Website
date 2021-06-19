import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;

  ThemeProvider({bool isDarkMode}) {
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDark => themeMode == ThemeMode.light;
  void toggleTheme(bool isOn) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (isOn) {
      themeMode = ThemeMode.dark;
      _prefs.setBool('isDarkMode', true);
    } else {
      themeMode = ThemeMode.light;
      _prefs.setBool('isDarkMode', false);
    }
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
    scaffoldBackgroundColor: kColorDarkScaffold,
    primaryColor: Colors.teal,
    toggleableActiveColor: Colors.teal,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: kColorRed,
      cursorColor: kColorRed,
      selectionHandleColor: Colors.teal,
    ),
    colorScheme: ColorScheme.dark(),
    textTheme: TextTheme(
      headline1: TextStyle(color: kColorWhite),
    ),
    iconTheme: IconThemeData(color: kColorWhite),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(kColorWhite),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> state) {
          if (state.contains(MaterialState.pressed))
            return Colors.grey.withOpacity(0.2);
          return Colors.grey.withOpacity(0.1);
        }),
        foregroundColor: MaterialStateProperty.all<Color>(kColorWhite),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: kColorWhite,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            fontSize: 20,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Colors.teal,
      hoverColor: Colors.grey.withOpacity(0.1),
    ),
  );

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      // color: kColorWhite,
      elevation: 5,
      brightness: Brightness.dark,

      backgroundColor: kColorWhite,
      foregroundColor: kColorGrey,
    ),
    scaffoldBackgroundColor: kColorWhite,
    primaryColor: Colors.red,
    toggleableActiveColor: Colors.red,
    colorScheme: ColorScheme.light(),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.red[900],
      cursorColor: Colors.red[900],
      selectionHandleColor: kColorRed,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: kColorWhite),
    ),
    iconTheme: IconThemeData(color: kColorWhite),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(kColorWhite),
        backgroundColor: MaterialStateProperty.all<Color>(kColorRed),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> state) {
          if (state.contains(MaterialState.pressed))
            return Colors.grey.withOpacity(0.2);
          return Colors.grey.withOpacity(0.1);
        }),
        foregroundColor: MaterialStateProperty.all<Color>(kColorGrey),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            fontSize: 20,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Colors.red,
      hoverColor: Colors.grey.withOpacity(0.1),
    ),
  );
}
