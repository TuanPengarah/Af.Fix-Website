import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';

Future<void> showSettingMenu(BuildContext context) async {
  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(430, 80, 10, 100),
    items: [
      PopupMenuItem(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: kColorWhiteDark,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${AppLocalizations.of(context).translate('usernotsign')}',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      PopupMenuDivider(),
      PopupMenuItem<int>(
        value: 0,
        child: Text('${AppLocalizations.of(context).translate('language')}'),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: Text('${AppLocalizations.of(context).translate('darktheme')}'),
      ),
    ],
  );
  if (selected == 0) {
    print('do something');
  } else if (selected == 1) {
    print('do something 1');
  }
}
