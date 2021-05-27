import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/menu/menu_change_language.dart';
import 'package:affix_web/menu/menu_change_theme.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/MyRepairID/myrepairID_page.dart';
import 'package:affix_web/screen/navbar/navbar_landingPage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyrepairIDWrapper extends StatefulWidget {
  @override
  _MyrepairIDWrapperState createState() => _MyrepairIDWrapperState();
}

class _MyrepairIDWrapperState extends State<MyrepairIDWrapper> {
  @override
  Widget build(BuildContext context) {
    bool _dahrunning = false;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1200) {
          if (_dahrunning == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Add Your Code here.
              Provider.of<UpdateUI>(context, listen: false).animationStartSmall(
                  wAnimDesk: 140, hAnimDesk: 90, wAnimMob: 120, hAnimMob: 80);
              _dahrunning = true;
            });
          }

          return DekstopMyRepairID();
        }
        return MobileMyRepairID();
      },
    );
  }
}

class DekstopMyRepairID extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: Stack(
          children: [
            MyRepairIDContainer(),
            Navbar(),
          ],
        ),
      ),
    );
  }
}

class MobileMyRepairID extends StatefulWidget {
  @override
  _MobileMyRepairIDState createState() => _MobileMyRepairIDState();
}

class _MobileMyRepairIDState extends State<MobileMyRepairID> {
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    'uid: ${Provider.of<UpdateUI>(context).uid}',
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
          Builder(
            builder: (BuildContext context) => IconButton(
              tooltip: 'Menu',
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }
}
