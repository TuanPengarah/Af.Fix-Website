import 'package:affix_web/config/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateUI extends ChangeNotifier {
  double widthAnimDeks = 240;
  double heightAnimDeks = 150;
  double widthAnimMob = 150;
  double heightAnimMob = 100;
  bool isMobile = true;
  Color changeColor = kColorGrey;
  Color changeLogoColor = kColorRed;

  animationStartSmall(
      {double wAnimDesk, double hAnimDesk, double wAnimMob, double hAnimMob}) {
    widthAnimDeks = wAnimDesk;
    heightAnimDeks = hAnimDesk;
    widthAnimMob = wAnimMob;
    heightAnimMob = hAnimMob;
    notifyListeners();
  }

  animationStartBig(
      {double wAnimDesk, double hAnimDesk, double wAnimMob, double hAnimMob}) {
    widthAnimDeks = wAnimDesk;
    heightAnimDeks = hAnimDesk;
    widthAnimMob = wAnimMob;
    heightAnimMob = hAnimMob;
    notifyListeners();
  }

  isThisMobile(bool mobile) {
    isMobile = mobile;
    // notifyListeners();
  }

  changeColorDarkWhite(Color newColor) {
    changeColor = newColor;
    notifyListeners();
  }

  changeLogoColorRedWhite(Color newColor) {
    changeLogoColor = newColor;
    notifyListeners();
  }
}
