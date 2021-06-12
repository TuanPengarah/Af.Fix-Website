import 'package:affix_web/config/constant.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/e-warranty/mobileView/ewarranty_page.dart';
import 'package:affix_web/screen/e-warranty/mobileView/history_page.dart';
import 'package:affix_web/screen/e-warranty/ui/avatar.dart';
import 'package:affix_web/screen/e-warranty/ui/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}

class EwarrantyHome extends StatefulWidget {
  @override
  _EwarrantyHomeState createState() => _EwarrantyHomeState();
}

class _EwarrantyHomeState extends State<EwarrantyHome> {
  int _selectablePage = 1;
  PageController _pageController;

  void _clickPage(int pageNum) {
    setState(() {
      _selectablePage = pageNum;
      _pageController.animateToPage(pageNum,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _uidText = Provider.of<UpdateUI>(context).uid;
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    String _userName = Provider.of<UpdateUI>(context).userName.toLowerCase();
    final _name = _userName.capitalizeFirstofEach;
    return Scaffold(
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxHeight > 1200) {}
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: userProfile(_name, context),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabButton(
                        tabName: 'E-Warranti',
                        pageNumber: 0,
                        icon: MaterialCommunityIcons.book_open_outline,
                        selectablePage: _selectablePage,
                        onPressed: () {
                          _clickPage(0);
                        },
                      ),
                      TabButton(
                        tabName: 'Sejarah baiki',
                        pageNumber: 1,
                        selectablePage: _selectablePage,
                        onPressed: () {
                          _clickPage(1);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (int change) {
                      setState(() {
                        _selectablePage = change;
                      });
                    },
                    controller: _pageController,
                    children: [
                      eWarrantyPage(_uidText, _name),
                      historyRepairPage(_uidText, _name, _isDarkMode)
                    ],
                  ),
                ),
              ],
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (BuildContext context) => IconButton(
                tooltip: 'Menu',
                icon: Icon(
                  Icons.menu,
                  color: _isDarkMode == false ? kColorWhite : kColorGrey,
                ),
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
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                tooltip: 'Tutup',
                icon: Icon(
                  Icons.close,
                  color: _isDarkMode == false ? kColorWhite : kColorGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
