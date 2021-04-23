import 'package:flutter/foundation.dart';

class UpdateUI extends ChangeNotifier {
  double widthAnimDeks = 240;
  double heightAnimDeks = 150;
  double widthAnimMob = 150;
  double heightAnimMob = 100;

  animationStartSmall(
      {double wAnimDesk, double hAnimDesk, double wAnimMob, double hAnimMob}) {
    widthAnimDeks = wAnimDesk;
    heightAnimDeks = hAnimDesk;
    widthAnimMob = wAnimMob;
    heightAnimMob = hAnimMob;
    ChangeNotifier();
  }

  animationStartBig(
      {double wAnimDesk, double hAnimDesk, double wAnimMob, double hAnimMob}) {
    widthAnimDeks = wAnimDesk;
    heightAnimDeks = hAnimDesk;
    widthAnimMob = wAnimMob;
    heightAnimMob = hAnimMob;
    ChangeNotifier();
  }
// animationStartSmall() {
//   widthAnimDeks = 140;
//   heightAnimDeks = 90;
//   widthAnimMob = 120;
//   heightAnimMob = 80;
// }

// animationStartBig() {
//   widthAnimDeks = 240;
//   heightAnimDeks = 150;
//   widthAnimMob = 150;
//   heightAnimMob = 100;
// }

}
