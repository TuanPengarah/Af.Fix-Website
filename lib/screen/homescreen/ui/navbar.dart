import 'package:affix_web/config/constant.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final title;

  Navbar({this.title}) : preferredSize = Size.fromHeight(60.0);

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1200) {
          return DekstopNav();
        } else if (constraints.maxWidth > 820 && constraints.maxWidth < 1200) {
          return MobileNav();
        } else {
          return MobileNav();
        }
      },
    );
  }
}

class MobileNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: 15,
      borderRadius: BorderRadius.vertical(),
      bgColor: kColorGrey,
      height: 80,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/web_logo.png',
                height: 80,
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: kColorWhite,
                      ),
                      onPressed: () {})
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DekstopNav extends StatelessWidget {
  const DekstopNav({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: scrollPosition < 20 ? 1 : 15,
      borderRadius: BorderRadius.vertical(),
      bgColor: scrollPosition < 20 ? Colors.transparent : kColorGrey,
      height: 100,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/web_logo.png',
                height: 60,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () {
                      scrollController.animateTo(60,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.decelerate);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Jom Repair',
                        style: kTextSubtitle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      scrollController.animateTo(1200,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.decelerate);
                    },
                    child: Text(
                      'Kelebihan',
                      style: TextStyle(
                        color: scrollPosition > 900 ? kColorRed : Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Servis Kami',
                      style: kTextSubtitle,
                    ),
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'Aplikasi',
                  //     style: kTextSubtitle,
                  //   ),
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'E-Waranti',
                      style: kTextSubtitle,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'MyRepair ID',
                      style: kTextSubtitle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
