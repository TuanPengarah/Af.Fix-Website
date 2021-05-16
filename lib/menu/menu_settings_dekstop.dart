import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:affix_web/config/change_lang.dart';
import 'package:provider/provider.dart';

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
    showLanguageDekstop(context);
  } else if (selected == 1) {
    showDarkModeDekstop(context);
  }
}

Future<void> showLanguageDekstop(BuildContext context) async {
  bool _isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDark;
  var appLanguage = Provider.of<AppLanguage>(context, listen: false);
  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(430, 80, 10, 100),
    items: [
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              size: 15,
              color: _isDarkMode ? kColorWhite : Colors.black,
            ),
            SizedBox(width: 15),
            Text('${AppLocalizations.of(context).translate('language')}'),
          ],
        ),
      ),
      PopupMenuDivider(),
      PopupMenuItem<int>(
        value: 1,
        child: Text('Bahasa Melayu'),
      ),
      PopupMenuItem<int>(
        value: 2,
        child: Text('English'),
      ),
    ],
  );
  if (selected == 0) {
    showSettingMenu(context);
  } else if (selected == 1) {
    appLanguage.changeLanguage(Locale("my"));
  } else if (selected == 2) {
    appLanguage.changeLanguage(Locale("en"));
  }
}

Future<void> showDarkModeDekstop(BuildContext context) async {
  bool _isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDark;
  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(430, 80, 10, 100),
    items: [
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              size: 15,
              color: _isDarkMode ? kColorWhite : Colors.black,
            ),
            SizedBox(width: 15),
            Text('${AppLocalizations.of(context).translate('darktheme')}'),
          ],
        ),
      ),
      PopupMenuDivider(),
      PopupMenuItem<int>(
        value: 1,
        child: Text('${AppLocalizations.of(context).translate('on')}'),
      ),
      PopupMenuItem<int>(
        value: 2,
        child: Text('${AppLocalizations.of(context).translate('off')}'),
      ),
    ],
  );
  if (selected == 0) {
    showSettingMenu(context);
  } else if (selected == 1) {
    _isDarkMode
        ? print('dark theme dah on le')
        : Provider.of<ThemeProvider>(context, listen: false).toggleTheme(true);
  } else if (selected == 2) {
    _isDarkMode
        ? Provider.of<ThemeProvider>(context, listen: false).toggleTheme(false)
        : print('dark theme dah off le');
  }
}
