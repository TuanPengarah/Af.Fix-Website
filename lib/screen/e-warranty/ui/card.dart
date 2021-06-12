import 'package:affix_web/config/constant.dart';
import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget warrantyCard({
  BuildContext context,
  String phoneModel,
  int harga,
  String rosak,
  String uid,
  String warrantyStart,
  String warrantyAkhir,
  bool warrantiKe = false,
  bool isDark,
  bool tengahRepair = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      width: MediaQuery.of(context).size.width - 30,
      child: Card(
        color: warrantiKe == true
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        child: tengahRepair == true
            ? Shimmer.fromColors(
                highlightColor: Theme.of(context).primaryColor,
                baseColor: warrantiKe == true
                    ? Colors.white
                    : isDark == true
                        ? kColorGrey
                        : Colors.white,
                child: _normalCard(uid, warrantiKe, isDark, phoneModel, context,
                    rosak, warrantyStart, harga, tengahRepair, warrantyAkhir),
              )
            : Container(
                child: _normalCard(uid, warrantiKe, isDark, phoneModel, context,
                    rosak, warrantyStart, harga, tengahRepair, warrantyAkhir),
              ),
      ),
    ),
  );
}

Padding _normalCard(
    String uid,
    bool warrantiKe,
    bool isDark,
    String phoneModel,
    BuildContext context,
    String rosak,
    String warrantyStart,
    int harga,
    bool tengahRepair,
    String warrantyAkhir) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Tooltip(
              message: 'MySID',
              child: SelectableText(
                '$uid',
                style: TextStyle(
                  fontSize: 12,
                  color: warrantiKe == true
                      ? Colors.white60
                      : isDark == true
                          ? Colors.black54
                          : Colors.white60,
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarLetter(
                  text: phoneModel,
                  textColor: warrantiKe == true
                      ? Theme.of(context).primaryColor
                      : kColorWhite,
                  textColorHex: null,
                  backgroundColor:
                      warrantiKe == true ? kColorWhite : Colors.grey,
                  backgroundColorHex: null,
                  letterType: LetterType.Rectangle,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      '$phoneModel',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: warrantiKe == true
                            ? Colors.white
                            : isDark == true
                                ? kColorGrey
                                : Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    SelectableText(
                      '$rosak',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 15,
                        color: warrantiKe == true
                            ? Colors.white
                            : isDark == true
                                ? kColorGrey
                                : Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    SelectableText(
                      '$warrantyStart',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 15,
                        color: warrantiKe == true
                            ? Colors.white
                            : isDark == true
                                ? kColorGrey
                                : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SelectableText(
              'RM${harga.toString()}',
              style: TextStyle(
                fontSize: 23,
                color: warrantiKe == true
                    ? Colors.white
                    : isDark == true
                        ? kColorGrey
                        : Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              warrantiKe == true
                  ? Icons.done
                  : tengahRepair == true
                      ? Icons.medical_services_rounded
                      : Icons.cancel_presentation_rounded,
              size: 13,
              color: warrantiKe == true
                  ? Colors.white
                  : isDark == true
                      ? kColorGrey
                      : Colors.white,
            ),
            SizedBox(width: 9),
            SelectableText(
              warrantiKe == true
                  ? 'Waranti anda sah sehingga $warrantyAkhir'
                  : tengahRepair == true
                      ? 'Peranti anda sedang dibaiki'
                      : 'Waranti anda sudah tamat pada $warrantyAkhir',
              style: TextStyle(
                fontSize: 13,
                color: warrantiKe == true
                    ? Colors.white60
                    : isDark == true
                        ? Colors.black54
                        : Colors.white60,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
