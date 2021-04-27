import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/ui/first_landing.dart';
import 'package:affix_web/screen/homescreen/ui/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

ScrollController scrollController = ScrollController();
double scrollPosition = 0;
bool atasSekali = true;
bool dahRunning = false;

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _animColor;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    _animColor = ColorTween(begin: kColorGrey, end: kColorWhite)
        .animate(_animationController)
          ..addListener(() {
            Provider.of<UpdateUI>(context, listen: false)
                .colorTweenDarkWhite(_animColor.value);
          });
  }

  _scrollListener() {
    scrollPosition = scrollController.position.pixels;
    // print(scrollPosition);
    if (dahRunning == false) {
      if (scrollPosition > 60 && scrollPosition <= 190) {
        Provider.of<UpdateUI>(context, listen: false).animationStartSmall(
            wAnimDesk: 140, hAnimDesk: 90, wAnimMob: 120, hAnimMob: 80);
        atasSekali = false;
        Future.delayed(Duration(milliseconds: 200), () {
          _animationController.forward();
        });
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
      _animationController.reverse();
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
      drawer: Drawer(),
      body: Scrollbar(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
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
                    color: Provider.of<UpdateUI>(context).colorWhiteDark,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              actions: [
                IconButton(
                  tooltip: 'Our Social Media',
                  icon: Icon(
                    MaterialCommunityIcons.contacts,
                    color: Provider.of<UpdateUI>(context).colorWhiteDark,
                  ),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'AF.FIX',
                  style: TextStyle(
                    color: Provider.of<UpdateUI>(context).colorWhiteDark,
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
