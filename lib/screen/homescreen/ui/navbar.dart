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
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Image.asset(
              //     'assets/images/logo_web_dark.jpg',
              //     height: 70,
              //   ),
              // ),
              Center(
                child: Row(
                  children: [
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
                          color: scrollPosition > 900 ? kColorRed : kColorGrey,
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
                        style: kTextSubtitleDark,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          'Jom Baiki',
                          style: kTextSubtitle,
                        ),
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
                        style: kTextSubtitleDark,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'MyRepair ID',
                        style: kTextSubtitleDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
