import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/menu/menu_change_language.dart';
import 'package:affix_web/menu/menu_change_theme.dart';
import 'package:affix_web/model/sweetLogoutDialog.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class EndDrawer extends StatelessWidget {
  EndDrawer({
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
    String _userName = Provider.of<UpdateUI>(context).userName;
    bool _isAnony = Provider.of<UpdateUI>(context).checkAnonymous;
    bool _isMobile = Provider.of<UpdateUI>(context).isMobile;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  _isAnony == true
                      ? '${AppLocalizations.of(context).translate('usernotsign')}'
                      : _userName.toString(),
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
          _isAnony == true
              ? Tooltip(
                  message:
                      '${AppLocalizations.of(context).translate('tooltipsignin')}',
                  child: ListTile(
                    trailing: Icon(Icons.login),
                    title: Text(
                        '${AppLocalizations.of(context).translate('signin')}'),
                    onTap: () {
                      Navigator.of(context).pop();
                      VxNavigator.of(context).push(Uri.parse(MyRoutes.login));
                    },
                  ),
                )
              : Tooltip(
                  message:
                      '${AppLocalizations.of(context).translate('tooltipsignout')}',
                  child: ListTile(
                    trailing: Icon(Icons.logout),
                    title: Text(
                        '${AppLocalizations.of(context).translate('signout')}'),
                    onTap: () {
                      showLogoutDialog(context)
                          .then((value) => Navigator.of(context).pop());
                    },
                  ),
                ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              height: 1,
              thickness: 1.5,
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
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                  label:
                      'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
                  primaryColor: Theme.of(context).primaryColor.value,
                ));
                Navigator.of(context).pop();
                context.vxNav.popToRoot();
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
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                  label:
                      'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
                  primaryColor: Theme.of(context).primaryColor.value,
                ));
                Navigator.of(context).pop();
                context.vxNav.popToRoot();
                scrollController.animateTo(_isMobile == true ? 1677 : 1200,
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
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                  label:
                      'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
                  primaryColor: Theme.of(context).primaryColor.value,
                ));
                Navigator.of(context).pop();
                context.vxNav.popToRoot();
                scrollController.animateTo(_isMobile == true ? 5500 : 2700,
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
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                  label: 'MyStatus ID - Af.Fix Smartphone Repair',
                  primaryColor: Theme.of(context).primaryColor.value,
                ));
                Navigator.of(context).pop();
                context.vxNav.push(Uri.parse(MyRoutes.myStatusID));
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
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              height: 1,
              thickness: 1.5,
            ),
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
