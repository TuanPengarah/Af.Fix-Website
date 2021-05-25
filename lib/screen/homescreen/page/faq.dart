import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';

class FAQ extends StatelessWidget {
  const FAQ({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Column(
          children: [
            SelectableText(
              'FAQ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 40,
              ),
            ),
            Container(
              width: 200,
              child: Divider(
                thickness: 1,
                // color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            SelectableText(
              'Frequently Asked Question',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 60),
            Column(
              children: [
                SlimyCard(
                  width: 350,
                  topCardHeight: 180,
                  bottomCardHeight: 180,
                  borderRadius: 0,
                  color: kColorGrey,
                  topCardWidget: topWidget(
                      'Model smartphone apakah yang boleh di repair?'),
                  bottomCardWidget: bottomWidget(
                      'iPhone dan Android, selagi ada sparepart selagi itu kami boleh repair'),
                ),
                SizedBox(height: 80),
                SlimyCard(
                  width: 350,
                  topCardHeight: 180,
                  borderRadius: 0,
                  bottomCardHeight: 100,
                  color: kColorGrey,
                  topCardWidget: topWidget('Tempoh waranti?'),
                  bottomCardWidget: bottomWidget('30 hari sehingga 90 hari'),
                ),
              ],
            ),
            SizedBox(height: 180),
          ],
        ),
      ),
    );
  }

  Widget topWidget(String question) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: kColorGrey,
        child: SelectableText(
          question,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            fontSize: 20,
            color: kColorWhite,
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(String answer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: kColorGrey,
        child: Container(
          color: kColorGrey,
          child: SelectableText(
            answer,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              fontSize: 20,
              color: kColorWhite,
            ),
          ),
        ),
      ),
    );
  }
}
