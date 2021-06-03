import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/MyStatusID/MyStatusID_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyStatusIDScaffold extends StatefulWidget {
  final String mysidData;

  MyStatusIDScaffold({this.mysidData});
  @override
  _MyStatusIDScaffoldState createState() => _MyStatusIDScaffoldState();
}

class _MyStatusIDScaffoldState extends State<MyStatusIDScaffold> {
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
                  tooltip: 'Back',
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    SystemChrome.setApplicationSwitcherDescription(
                        ApplicationSwitcherDescription(
                      label:
                          'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
                      primaryColor: Theme.of(context).primaryColor.value,
                    ));
                    Navigator.of(context).pop();
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
