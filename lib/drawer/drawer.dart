import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/menu/menu_change_language.dart';
import 'package:affix_web/menu/menu_change_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    Key key,
    @required String uidText,
    @required bool isDarkMode,
  })  : _uidText = uidText,
        _isDarkMode = isDarkMode,
        super(key: key);

  final String _uidText;
  final bool _isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  '${AppLocalizations.of(context).translate('usernotsign')}',
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxFontSize: 20,
                  minFontSize: 13,
                ),
                SizedBox(height: 5),
                SelectableText(
                  'uid: $_uidText',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Tooltip(
            message:
                '${AppLocalizations.of(context).translate('tooltipletrepair')}',
            child: ListTile(
              title: Text(AppLocalizations.of(context).translate('letsrepair')),
              onTap: () {},
            ),
          ),
          Tooltip(
            message:
                '${AppLocalizations.of(context).translate('tooltipabout')}',
            child: ListTile(
              title: Text(AppLocalizations.of(context).translate('about')),
              onTap: () {},
            ),
          ),
          Tooltip(
            message:
                '${AppLocalizations.of(context).translate('tooltipourservice')}',
            child: ListTile(
              title: Text(
                AppLocalizations.of(context).translate('ourservice'),
              ),
              onTap: () {},
            ),
          ),
          Tooltip(
            message:
                '${AppLocalizations.of(context).translate('tooltipewaranti')}',
            child: ListTile(
              title: Text(
                AppLocalizations.of(context).translate('ewarranti'),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Tooltip(
            message:
                '${AppLocalizations.of(context).translate('tooltipmyrid')}',
            child: ListTile(
              title: Text(
                AppLocalizations.of(context).translate('myrid'),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Tooltip(
            message:
                '${AppLocalizations.of(context).translate('tooltipsocial')}',
            child: ListTile(
              title: Text(
                AppLocalizations.of(context).translate('tooltipsocial'),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
          ),
          Tooltip(
            message:
                '${AppLocalizations.of(context).translate('tooltipchangelang')}',
            child: ListTile(
              title: Text(
                '${AppLocalizations.of(context).translate('language')}',
              ),
              trailing:
                  Text('${AppLocalizations.of(context).translate('locale')}'),
              onTap: () {
                showLanguage(context);
              },
            ),
          ),
          Tooltip(
            message:
                '${AppLocalizations.of(context).translate('tooltipdarktheme')}',
            child: ListTile(
              title: Text(
                  '${AppLocalizations.of(context).translate('darktheme')}'),
              trailing: Text(
                _isDarkMode == false
                    ? '${AppLocalizations.of(context).translate('on')}'
                    : '${AppLocalizations.of(context).translate('off')}',
              ),
              onTap: () {
                showDarkTheme(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
