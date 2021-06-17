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
  bool switchDarkMode = false;
  String uid;
  bool checkAnonymous = false;
  String userName = 'Af-Fix Smartphone Repair';
  String userPhoto;
  bool isRepair = true;

  setUserPhoto(String newPhoto) {
    userPhoto = newPhoto;
    notifyListeners();
  }

  setRepair(bool repairType) {
    isRepair = repairType;
    notifyListeners();
  }

  setUserName(String newName) {
    userName = newName;
    notifyListeners();
  }

  setAnonymous(bool newAnony) {
    checkAnonymous = newAnony;
    notifyListeners();
  }

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
    print('mobile: $isMobile');
    notifyListeners();
  }

  changeDarkMode(bool newMode) {
    switchDarkMode = !newMode;
    notifyListeners();
  }

  setUID(String newUID) {
    uid = newUID;
    notifyListeners();
  }

  String getUID() {
    notifyListeners();
    return uid.toString();
  }
}
