import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:affix_web/menu/menu_change_language.dart';
import 'package:affix_web/screen/homescreen/page/about.dart';
import 'package:affix_web/screen/homescreen/page/apps.dart';
import 'package:affix_web/screen/homescreen/page/call_us.dart';
import 'package:affix_web/screen/homescreen/page/customer_testimonial.dart';
import 'package:affix_web/screen/homescreen/page/first_landing.dart';
import 'package:affix_web/screen/homescreen/page/follow_socmed.dart';
import 'package:affix_web/screen/homescreen/page/footer.dart';
import 'package:affix_web/screen/homescreen/page/our_services.dart';
import 'package:affix_web/screen/homescreen/page/pwa.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import '../../menu/menu_change_theme.dart';
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
                onTap: () {
                  Navigator.of(context).pop();
                  if (scrollController.hasClients)
                    scrollController.animateTo(5000,
                        duration: Duration(milliseconds: 800),
                        curve: Curves.decelerate);
                },
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
                  Provider.of<UpdateUI>(context, listen: false)
                      .animationStartSmall(
                          wAnimDesk: 140,
                          hAnimDesk: 90,
                          wAnimMob: 120,
                          hAnimMob: 80);
                  context.vxNav.push(Uri.parse(MyRoutes.myRepairID));
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
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: _isDarkMode
                ? Theme.of(context).appBarTheme.backgroundColor
                : kColorWhite,
            elevation: 0,
            pinned: false,
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
                    color: kColorRed,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '.FIX',
                      style: TextStyle(
                        color: _isDarkMode ? kColorWhite : kColorGrey,
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
                          About(),
                          CallUs(),
                          OurServices(),
                          Apps(),
                          CustomerTestimonial(),
                          FollowSocialMedia(),
                          PWA(),
                          // FAQ(),
                          Footer(),
                        ],
                      ),
                      // Navbar(),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
