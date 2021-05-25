import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';

class PWA extends StatelessWidget {
  const PWA({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 120, bottom: 20, left: 5, right: 5),
        child: Column(
          children: [
            SelectableText(
              '${AppLocalizations.of(context).translate('usefultool')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                // color: kColorWhite,
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
            SizedBox(height: 60),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 60,
              runSpacing: 50,
              children: [
                pwaContainer(
                    'MyRepair ID',
                    '${AppLocalizations.of(context).translate('myridsubtitle')}',
                    '${AppLocalizations.of(context).translate('myridgobutton')}'),
                pwaContainer(
                    '${AppLocalizations.of(context).translate('ewarranti')}',
                    '${AppLocalizations.of(context).translate('ewaranttysubtitle')}',
                    '${AppLocalizations.of(context).translate('ewarrantygobutton')}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container pwaContainer(String title, String subtitle, String button) {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        color: kColorRed,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SelectableText(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: kColorWhite,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            SelectableText(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: kColorWhite,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kColorWhite),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  button,
                  style: TextStyle(
                    color: kColorRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
