import 'package:affix_web/config/constant.dart';
import 'package:affix_web/screen/homescreen/ui/first_landing.dart';
import 'package:affix_web/screen/homescreen/ui/navbar.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

ScrollController scrollController = ScrollController();
double scrollPosition = 0;

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    setState(() {
      scrollPosition = scrollController.position.pixels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: kColorWhite),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
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
            Navbar(),
          ],
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
