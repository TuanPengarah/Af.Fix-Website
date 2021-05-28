import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';

class Apps extends StatelessWidget {
  const Apps({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
        child: Column(
          children: [
            SelectableText(
              '${AppLocalizations.of(context).translate('newapps')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: kColorWhite,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: Divider(
                thickness: 1,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            SelectableText(
              '${AppLocalizations.of(context).translate('newappsdesc')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: kColorWhite,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Image(
              alignment: Alignment.bottomCenter,
              height: 400,
              width: 400,
              image: NetworkImage(kImageAppsDemo),
            ),
          ],
        ),
      ),
    );
  }
}
