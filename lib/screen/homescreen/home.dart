import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/mobile_home.dart';
import 'package:affix_web/screen/homescreen/ui/first_landing.dart';
import 'package:affix_web/screen/homescreen/ui/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

ScrollController scrollController = ScrollController();
double scrollPosition = 0;
bool atasSekali = true;
bool dahRunningDekstop = false;
bool dahRunningMobile = false;

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 50.0);
    scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    scrollPosition = scrollController.position.pixels;
    // print(scrollPosition);
    if (dahRunningMobile == true) {
      if (scrollPosition < 200) {
        Provider.of<UpdateUI>(context, listen: false)
            .changeColorDarkWhite(kColorGrey);
        dahRunningMobile = false;
        Provider.of<UpdateUI>(context, listen: false)
            .changeLogoColorRedWhite(kColorRed);
      }
    }
    if (dahRunningDekstop == false) {
      if (scrollPosition > 60 && scrollPosition < 190) {
        Provider.of<UpdateUI>(context, listen: false).animationStartSmall(
            wAnimDesk: 140, hAnimDesk: 90, wAnimMob: 120, hAnimMob: 80);
        atasSekali = false;
        dahRunningDekstop = true;
      }
    }
    if (dahRunningMobile == false) {
      if (scrollPosition > 200) {
        Provider.of<UpdateUI>(context, listen: false)
            .changeColorDarkWhite(kColorWhite);
        Provider.of<UpdateUI>(context, listen: false)
            .changeLogoColorRedWhite(kColorWhite);

        dahRunningMobile = true;
      }
    }
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
//do logic untuk bawah sekali
        atasSekali = false;
        dahRunningDekstop = false;
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
      dahRunningDekstop = false;
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
