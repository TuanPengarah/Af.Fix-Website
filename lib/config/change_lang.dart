import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('my');
  bool isMalay;

  isThisMalay(bool newLang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMalay = prefs.getBool('isMalay') ?? true;
    isMalay = newLang;
    print('bm: $isMalay');
    await prefs.setBool('isMalay', newLang);
    notifyListeners();
  }

  Locale get appLocal => _appLocale ?? Locale("my");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("my")) {
      _appLocale = Locale("my");
      isThisMalay(true);
      await prefs.setString('language_code', 'my');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      isThisMalay(false);
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }

  checkSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isMalay == null) {
      print('tngah jalan');
      isMalay = prefs.getBool('isMalay') ?? true;
      notifyListeners();
    }
  }
}
