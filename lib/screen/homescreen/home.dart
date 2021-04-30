import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/ui/first_landing.dart';
import 'package:affix_web/screen/homescreen/ui/navbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

ScrollController scrollController = ScrollController();
double scrollPosition = 0;
bool atasSekali = true;
bool dahRunning = false;
bool _switch = false;

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    scrollPosition = scrollController.position.pixels;
    // print(scrollPosition);
    if (dahRunning == true) {
      if (scrollPosition < 60) {
        Provider.of<UpdateUI>(context, listen: false)
            .changeColorDarkWhite(kColorGrey);
        dahRunning = false;
        Provider.of<UpdateUI>(context, listen: false)
            .changeLogoColorRedWhite(kColorRed);
      }
    }
    if (dahRunning == false) {
      if (scrollPosition > 60 && scrollPosition < 190) {
        Provider.of<UpdateUI>(context, listen: false).animationStartSmall(
            wAnimDesk: 140, hAnimDesk: 90, wAnimMob: 120, hAnimMob: 80);
        atasSekali = false;

        Provider.of<UpdateUI>(context, listen: false)
            .changeColorDarkWhite(kColorWhite);
        Provider.of<UpdateUI>(context, listen: false)
            .changeLogoColorRedWhite(kColorWhite);

        dahRunning = true;
      }
    }
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
//do logic untuk bawah sekali
        atasSekali = false;
        dahRunning = false;
      });
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
//do logic untuk atas sekali
      Provider.of<UpdateUI>(context, listen: false).animationStartBig(
          wAnimDesk: 240, hAnimDesk: 150, wAnimMob: 150, hAnimMob: 100);
      // Provider.of<UpdateUI>(context, listen: false)
      //     .changeColorDarkWhite(kColorGrey);
      atasSekali = true;
      dahRunning = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1200) {
          return DekstopHomeView();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          return MobileHomeView();
        } else {
          return MobileHomeView();
        }
      },
    );
  }
}

class MobileHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                color: kColorRed,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('letsrepair')),
              onTap: () {
                Navigator.of(context).pop();
                scrollController.animateTo(0,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.decelerate);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('about')),
              onTap: () {
                Provider.of<UpdateUI>(context, listen: false)
                    .changeColorDarkWhite(kColorWhite);
                Provider.of<UpdateUI>(context, listen: false)
                    .changeLogoColorRedWhite(kColorWhite);
                Navigator.of(context).pop();
                scrollController.animateTo(1677,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.decelerate);
              },
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context).translate('ourservice'),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context).translate('ewarranti'),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context).translate('myrid'),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            ListTile(
              title: Text(
                '${AppLocalizations.of(context).translate('language')}',
              ),
              trailing:
                  Text('${AppLocalizations.of(context).translate('locale')}'),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                  '${AppLocalizations.of(context).translate('darktheme')}'),
              trailing: SwitcherButton(
                value: _switch,
                onChange: (newValue) {
                  _switch = !newValue;
                },
                onColor: kColorRed,
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
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              pinned: true,
              floating: false,
              snap: false,
              expandedHeight: 160.0,
              leading: Builder(
                builder: (BuildContext context) => IconButton(
                  tooltip: 'Menu',
                  icon: Icon(
                    Icons.menu,
                    color: Provider.of<UpdateUI>(context).changeColor,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
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
                          color: Provider.of<UpdateUI>(context).changeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
                background: Container(color: kColorWhite),
              ),
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

class DekstopHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrimaryScrollController(
        controller: scrollController,
        child: Container(
          decoration: BoxDecoration(color: kColorWhite),
          child: Stack(
            children: [
              Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Navbar(),
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
                ),
              ),
              Navbar(),
            ],
          ),
        ),
      ),
    );
  }
}

// appBar: AppBar(
//   title: Text('Home'),
// ),
// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     context.vxNav.push(Uri.parse(MyRoutes.myRepairID));
//   },
// ),
