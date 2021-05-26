import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/change_lang.dart';
import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

class FAQ extends StatelessWidget {
  const FAQ({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isMalay = Provider.of<AppLanguage>(context).isMalay;
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
                      '${AppLocalizations.of(context).translate('qmodel')}'),
                  bottomCardWidget: bottomWidget(_isMalay == true
                      ? 'iPhone dan Android, selagi ada sparepart selagi itu kami boleh repair'
                      : 'iPhone and Android, as long as there are spare parts as long as we can repair'),
                ),
                SizedBox(height: 40),
                SlimyCard(
                  width: 350,
                  topCardHeight: 180,
                  borderRadius: 0,
                  bottomCardHeight: 100,
                  color: kColorGrey,
                  topCardWidget: topWidget(
                      '${AppLocalizations.of(context).translate('qwarranty')}'),
                  bottomCardWidget: bottomWidget(_isMalay == true
                      ? '30 hari sehingga 90 hari'
                      : '30 to 90 days'),
                ),
                SizedBox(height: 40),
                SlimyCard(
                  width: 350,
                  topCardHeight: 180,
                  borderRadius: 0,
                  bottomCardHeight: 160,
                  color: kColorGrey,
                  topCardWidget: topWidget(
                      '${AppLocalizations.of(context).translate('qmotherboard')}'),
                  bottomCardWidget: bottomWidget(_isMalay == true
                      ? 'Ye boleh repair motherboard smartphone. Terutamanya model iPhone dan Android(Jika ada alat ganti)'
                      : 'Yes we can repair smartphone motherboards. Especially iPhone and Android models (If there are spare parts for android)'),
                ),
                SizedBox(height: 40),
                SlimyCard(
                  width: 350,
                  topCardHeight: 180,
                  borderRadius: 0,
                  bottomCardHeight: 250,
                  color: kColorGrey,
                  topCardWidget: topWidget(
                      '${AppLocalizations.of(context).translate('qhowlong')}'),
                  bottomCardWidget: bottomWidget(_isMalay == true
                      ? 'Bergantung kepada jenis kerosakkan, jika kerosakkan jenis minor mengambil masa dalam 30 minit hingga 1 hari, Jika kerosakkan melibatkan motherboard ia kemungkinan mengambil masa 3 - 14 hari'
                      : 'Depending on the type of damage, if the minor damage takes 30 minutes to 1 day, If the damage involves the motherboard it may take 3 - 14 days'),
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
