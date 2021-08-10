import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/check_version.dart';
import 'package:affix_web/main.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/mobile_home.dart';
import 'package:affix_web/screen/homescreen/page/about.dart';
import 'package:affix_web/screen/homescreen/page/apps.dart';
import 'package:affix_web/screen/homescreen/page/call_us.dart';
import 'package:affix_web/screen/homescreen/page/customer_testimonial.dart';
import 'package:affix_web/screen/homescreen/page/first_landing.dart';
import 'package:affix_web/screen/homescreen/page/follow_socmed.dart';
import 'package:affix_web/screen/homescreen/page/footer.dart';
import 'package:affix_web/screen/homescreen/page/our_services.dart';
import 'package:affix_web/screen/homescreen/page/pwa.dart';
import 'package:affix_web/navbar/navbar_landingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

ScrollController scrollController = ScrollController();
double scrollPosition = 0;
bool atasSekali = true;
bool dahRunningDesktop = false;
FirebaseAuth _auth = FirebaseAuth.instance;
double setVersion;

class _LandingPageState extends State<LandingPage> {
  _scrollListener() {
    scrollPosition = scrollController.position.pixels;
    if (dahRunningDesktop == false) {
      if (scrollPosition > 60 && scrollPosition < 190) {
        Provider.of<UpdateUI>(context, listen: false).animationStartSmall(
            wAnimDesk: 140, hAnimDesk: 90, wAnimMob: 120, hAnimMob: 80);
        atasSekali = false;
        dahRunningDesktop = true;
      }
    }
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
//do logic untuk bawah sekali
      atasSekali = false;
      dahRunningDesktop = false;
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
//do logic untuk atas sekali
      Provider.of<UpdateUI>(context, listen: false).animationStartBig(
          wAnimDesk: 240, hAnimDesk: 150, wAnimMob: 150, hAnimMob: 100);
      // Provider.of<UpdateUI>(context, listen: false)
      //     .changeColorDarkWhite(kColorGrey);
      atasSekali = true;
      dahRunningDesktop = false;
    }
  }

  _authServices(BuildContext context) async {
    print('already login');
    String uid = await context.read<AuthenticationServices>().getUID();
    String retrieve =
        await context.read<AuthenticationServices>().getUserName();
    String retrieveEmail =
        await context.read<AuthenticationServices>().getEmail();
    Provider.of<UpdateUI>(context, listen: false)
        .setUserName(retrieve != null ? retrieve : retrieveEmail);
    String userPhoto =
        await context.read<AuthenticationServices>().getUserPhoto();

    if (retrieve == null && retrieveEmail == null) {
      Provider.of<UpdateUI>(context, listen: false).setAnonymous(true);
      Provider.of<UpdateUI>(context, listen: false).setUserName(
          '${AppLocalizations.of(context).translate('usernotsign')}');
    } else {
      Provider.of<UpdateUI>(context, listen: false).setAnonymous(false);
    }

    Provider.of<UpdateUI>(context, listen: false).setUID(uid);
    Provider.of<UpdateUI>(context, listen: false).setUserPhoto(userPhoto);
  }

  _registerAnonymous(BuildContext context) async {
    print('initialize anonymouse');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UpdateUI>(context, listen: false).setAnonymous(true);
      Provider.of<UpdateUI>(context, listen: false).setUID('N/A');

      if (_auth.currentUser != null) {
        _authServices(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    CheckVersion().checkVersion().then((v) {
      if (v == true) {
        navigatorKey.currentState.showSnackBar(SnackBar(
          content:
              Text('${AppLocalizations.of(context).translate('newversion')}'),
          action: SnackBarAction(
            label: '${AppLocalizations.of(context).translate('updatebutton')}',
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setDouble('webVersion', setVersion);

              html.window.location.reload();
            },
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
      primaryColor: Theme.of(context).primaryColor.value,
    ));

    // SET AUTH

    return StreamBuilder<User>(
        stream: _auth.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _authServices(context);
          } else {
            _registerAnonymous(context);
          }

          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 1200) {
                return DekstopHomeView();
              } else if (constraints.maxWidth > 800 &&
                  constraints.maxWidth < 1200) {
                return MobileHomeView();
              } else {
                return MobileHomeView();
              }
            },
          );
        });
  }
}

class DekstopHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrimaryScrollController(
        controller: scrollController,
        child: Container(
          child: Stack(
            children: [
              Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FirstLanding(),
                      About(),
                      CallUs(),
                      OurServices(),
                      Apps(),
                      CustomerTestimonial(),
                      FollowSocialMedia(),
                      PWA(),
                      // FAQ(),
                      Footer(),
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
