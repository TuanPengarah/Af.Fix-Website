import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/change_lang.dart';
import 'package:affix_web/menu/dialog_change%20language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showLanguage(BuildContext context) async {
  var appLanguage = Provider.of<AppLanguage>(context, listen: false);
  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(400, 600, 10, 80),
    items: [
      PopupMenuItem<int>(
        value: 0,
        child: Text('Bahasa Melayu'),
      ),
      PopupMenuItem<int>(value: 1, child: Text('English')),
    ],
  );
  if (selected == 0) {
    showGlobalDialog(context, () {
      Navigator.of(context).pop();
      appLanguage.changeLanguage(Locale("my"));
    }, '${AppLocalizations.of(context).translate('dialogchangemy')}',
        '${AppLocalizations.of(context).translate('dialogglobalsubtitle')}');
  } else if (selected == 1) {
    showGlobalDialog(context, () {
      Navigator.of(context).pop();
      appLanguage.changeLanguage(Locale("en"));
    }, '${AppLocalizations.of(context).translate('dialogchangeen')}',
        '${AppLocalizations.of(context).translate('dialogglobalsubtitle')}');
  }
}
