import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/config/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:affix_web/screen/homescreen/ui/menu_change_language.dart';
import 'package:affix_web/screen/homescreen/ui/first_landing.dart';
import 'package:affix_web/screen/homescreen/ui/navbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:affix_web/config/themeUI_provider.dart';
import 'ui/menu_change_theme.dart';
import 'package:velocity_x/velocity_x.dart';

class MobileHomeView extends StatelessWidget {
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
                onTap: () {
                  Navigator.of(context).pop();
                  scrollController.animateTo(0,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.decelerate);
                },
              ),
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipabout')}',
              child: ListTile(
                title: Text(AppLocalizations.of(context).translate('about')),
                onTap: () {
                  Provider.of<UpdateUI>(context, listen: false)
                      .changeColorDarkWhite(kColorWhite);
                  Provider.of<UpdateUI>(context, listen: false)
                      .changeLogoColorRedWhite(kColorWhite);
                  Navigator.of(context).pop();
                  if (scrollController.hasClients)
                    scrollController.animateTo(1677,
                        duration: Duration(milliseconds: 800),
                        curve: Curves.decelerate);
                },
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
                onTap: () {},
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
                  context.vxNav.push(Uri.parse(MyRoutes.myRepairID));
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
      body: Scrollbar(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              elevation: 0,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              pinned: true,
              floating: false,
              snap: false,
              expandedHeight: 280.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text.rich(
                  TextSpan(
                    text: 'AF',
                    style: TextStyle(
                      fontFamily: 'MotionControl',
                      fontSize: 60,
                      color: Provider.of<UpdateUI>(context).changeLogoColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '.FIX',
                        style: TextStyle(
                          color: _isDarkMode
                              ? kColorWhite
                              : Provider.of<UpdateUI>(context).changeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
                background: Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 250,
                        alignment: Alignment.topCenter,
                        width: 250,
                        child: Image.asset(
                          _isDarkMode
                              ? 'assets/images/logo_only_white.png'
                              : 'assets/images/logo_only_black.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Builder(
                  builder: (BuildContext context) => IconButton(
                    tooltip: 'Menu',
                    icon: Icon(
                      Icons.menu,
                      color: _isDarkMode
                          ? Colors.white
                          : Provider.of<UpdateUI>(context).changeColor,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(color: kColorWhite),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            FirstLanding(),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: kColorRed,
                              ),
                            ),
                          ],
                        ),
                        Navbar(),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
