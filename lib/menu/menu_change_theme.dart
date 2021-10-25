import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/menu/dialog_change%20language.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showDarkTheme(BuildContext context) async {
  bool _isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDark;
  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(400, 650, 9, 100),
    items: [
      PopupMenuItem<int>(
        value: 0,
        child: Text('${AppLocalizations.of(context).translate('on')}'),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: Text('${AppLocalizations.of(context).translate('off')}'),
      ),
    ],
  );
  if (selected == 0) {
    _isDarkMode == false
        ? print('dark theme dah on le')
        : showGlobalDialog(context, () {
            Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme(true);
          }, '${AppLocalizations.of(context).translate('dialogdarkon')}',
            '${AppLocalizations.of(context).translate('dialogglobalsubtitle')}');
  } else if (selected == 1) {
    _isDarkMode == false
        ? showGlobalDialog(context, () {
            Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme(false);
          }, '${AppLocalizations.of(context).translate('dialogdarkoff')}',
            '${AppLocalizations.of(context).translate('dialogglobalsubtitle')}')
        : print('dark theme dah off le');
  }
}
