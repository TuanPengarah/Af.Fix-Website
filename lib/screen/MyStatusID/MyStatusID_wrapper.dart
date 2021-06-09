import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/MyStatusID/MyStatusID_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStatusIDScaffold extends StatefulWidget {
  final String mysidData;

  MyStatusIDScaffold({this.mysidData});
  @override
  _MyStatusIDScaffoldState createState() => _MyStatusIDScaffoldState();
}

class _MyStatusIDScaffoldState extends State<MyStatusIDScaffold> {
  _checkAnonymous(BuildContext context) async {
    bool _isAnony =
        Provider.of<UpdateUI>(context, listen: false).checkAnonymous;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isAnony == true && FirebaseAuth.instance.currentUser == null) {
        print('become assasins');
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await context.read<AuthenticationServices>().anonymousSignIn();
        });
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAnonymous(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    String _uidText = Provider.of<UpdateUI>(context).uid;

    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'MyStatus ID - Af.Fix Smartphone Repair',
      primaryColor: Theme.of(context).primaryColor.value,
    ));

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          MyRepairIDContainer(
            mySIDText: widget.mysidData,
          ),
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
                  tooltip:
                      '${AppLocalizations.of(context).translate('buttonclose')}',
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    SystemChrome.setApplicationSwitcherDescription(
                        ApplicationSwitcherDescription(
                      label:
                          'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
                      primaryColor: Theme.of(context).primaryColor.value,
                    ));
                    VxNavigator.of(context).popToRoot();
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
