import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/themeUI_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showDarkTheme(BuildContext context) async {
  bool _isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDark;
  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(400, 490, 9, 100),
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
    _isDarkMode
        ? print('dark theme dah on le')
        : Provider.of<ThemeProvider>(context, listen: false).toggleTheme(true);
  } else if (selected == 1) {
    _isDarkMode
        ? Provider.of<ThemeProvider>(context, listen: false).toggleTheme(false)
        : print('dark theme dah off le');
  }
}
