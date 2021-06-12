import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';

Row userProfile(String name, BuildContext context) {
  String _greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    }
    if (hour < 13) {
      return 'Selamat Tengah Hari';
    }
    return 'Selamat Petang';
  }

  return Row(
    children: [
      AvatarLetter(
        text: '$name',
        textColor: Colors.white,
        textColorHex: null,
        backgroundColor: Theme.of(context).primaryColor,
        backgroundColorHex: null,
        letterType: LetterType.Circular,
      ),
      SizedBox(width: 18),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            '${_greeting()},',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5),
          SelectableText(
            '$name',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}
