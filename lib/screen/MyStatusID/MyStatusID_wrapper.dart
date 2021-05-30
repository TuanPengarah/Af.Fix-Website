import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/menu/menu_change_language.dart';
import 'package:affix_web/menu/menu_change_theme.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/MyStatusID/MyStatusID_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyStatusIDScaffold extends StatefulWidget {
  @override
  _MyStatusIDScaffoldState createState() => _MyStatusIDScaffoldState();
}

class _MyStatusIDScaffoldState extends State<MyStatusIDScaffold> {
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    String _uidText = Provider.of<UpdateUI>(context).uid;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      endDrawer: Drawer(
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
                title:
                    Text(AppLocalizations.of(context).translate('letsrepair')),
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
                  _isDarkMode
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
      ),
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          MyRepairIDContainer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (BuildContext context) => IconButton(
                tooltip: 'Menu',
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (BuildContext context) => IconButton(
                  tooltip: 'Back',
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
