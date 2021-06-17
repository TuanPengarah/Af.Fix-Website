import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/e-warranty/mobileView/ewarranty_page.dart';
import 'package:affix_web/screen/e-warranty/mobileView/history_page.dart';
import 'package:affix_web/screen/e-warranty/ui/avatar.dart';
import 'package:affix_web/screen/e-warranty/ui/tab_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'dekstopView/ui/tab_button_dekstop.dart';

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
  PageController _pageControllerDekstop;
  bool _onHover = true;
  bool _isMobile = false;
  User _user = FirebaseAuth.instance.currentUser;
  void _clickPage(int pageNum) {
    setState(() {
      _selectablePage = pageNum;
      _pageController.animateToPage(pageNum,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  void _clickPageDekstop(int pageNum) {
    setState(() {
      _selectablePage = pageNum;
      _pageControllerDekstop.jumpToPage(pageNum);
    });
  }

  @override
  void initState() {
    if (_isMobile == false) {
      Future.delayed(Duration(milliseconds: 1500), () {
        setState(() {
          _onHover = false;
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_isMobile == true) {
      _pageController.dispose();
    }

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
            if (constraints.maxWidth > 900) {
              _isMobile = false;
              _pageControllerDekstop =
                  PageController(initialPage: _selectablePage);
              return Row(
                children: [
                  MouseRegion(
                    onHover: (hover) {
                      setState(() {
                        _onHover = true;
                      });
                    },
                    onExit: (ex) {
                      setState(() {
                        _onHover = false;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _onHover = !_onHover;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: constraints.maxHeight,
                        width: _onHover == true ? 250 : 80,
                        color: Theme.of(context).primaryColor,
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 60),
                                    userProfile(
                                        _name, context, _isMobile, _isDarkMode),
                                  ],
                                ),
                                SizedBox(height: 50),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TabButtonDekstop(
                                      icon: MaterialCommunityIcons
                                          .book_open_outline,
                                      label:
                                          '${AppLocalizations.of(context).translate('ewarranti')}',
                                      selectablePage: _selectablePage,
                                      pageNumber: 0,
                                      onTap: () {
                                        _clickPageDekstop(0);
                                      },
                                    ),
                                    TabButtonDekstop(
                                      icon: Icons.history,
                                      label:
                                          '${AppLocalizations.of(context).translate('repairhistory')}',
                                      selectablePage: _selectablePage,
                                      pageNumber: 1,
                                      onTap: () {
                                        _clickPageDekstop(1);
                                      },
                                    ),
                                    TabButtonDekstop(
                                      icon: Icons.person,
                                      label: 'Profile',
                                      selectablePage: _selectablePage,
                                      pageNumber: 2,
                                      onTap: () {
                                        _clickPageDekstop(2);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (int change) {
                        setState(() {
                          _selectablePage = change;
                        });
                      },
                      scrollDirection: Axis.vertical,
                      controller: _pageControllerDekstop,
                      children: [
                        eWarrantyPage(_uidText, _name, _isMobile),
                        historyRepairPage(
                            _uidText, _name, _isDarkMode, _isMobile),
                        Container(
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                await context
                                    .read<AuthenticationServices>()
                                    .linktoGoogle();

                                Provider.of<UpdateUI>(context, listen: false)
                                    .setUserPhoto(_user.photoURL);
                              },
                              child: Text(
                                'Profile Page',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              _isMobile = true;
              _pageController = PageController(initialPage: _selectablePage);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                    child: userProfile(_name, context, _isMobile, _isDarkMode),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TabButton(
                          tabName:
                              '${AppLocalizations.of(context).translate('ewarranti')}',
                          pageNumber: 0,
                          icon: MaterialCommunityIcons.book_open_outline,
                          selectablePage: _selectablePage,
                          onPressed: () {
                            _clickPage(0);
                          },
                        ),
                        TabButton(
                          tabName:
                              '${AppLocalizations.of(context).translate('repairhistory')}',
                          pageNumber: 1,
                          selectablePage: _selectablePage,
                          onPressed: () {
                            _clickPage(1);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1),
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
                        eWarrantyPage(_uidText, _name, _isMobile),
                        historyRepairPage(
                            _uidText, _name, _isDarkMode, _isMobile)
                      ],
                    ),
                  ),
                ],
              );
            }
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
                  VxNavigator.of(context).popToRoot();
                },
                tooltip:
                    '${AppLocalizations.of(context).translate('buttonclose')}',
                icon: Icon(
                  Icons.close,
                  color: _isMobile == false
                      ? kColorWhite
                      : _isDarkMode == false
                          ? kColorWhite
                          : kColorGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
