import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';

Widget warrantyCard({
  BuildContext context,
  String phoneModel,
  int harga,
  String rosak,
  String uid,
  String warrantyStart,
  String warrantyAkhir,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      color: Colors.white60,
                      fontSize: 12,
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
                      textColor: Theme.of(context).primaryColor,
                      textColorHex: null,
                      backgroundColor: Colors.red[50],
                      backgroundColorHex: null,
                      letterType: LetterType.Circular,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          '$phoneModel',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        SelectableText(
                          '$rosak',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        SelectableText(
                          '$warrantyStart',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 15,
                            color: Colors.white,
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
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ],
            ),
            SizedBox(height: 10),
            SelectableText(
              'Waranti sah sehingga $warrantyAkhir',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
