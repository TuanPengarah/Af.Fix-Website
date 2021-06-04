import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/not_found_page.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/MyStatusID/MyStatusID_wrapper.dart';
import 'package:affix_web/screen/MyStatusID/repair_report.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'config/change_lang.dart';
import 'provider/themeUI_provider.dart';
// flutter run -d web-server --web-port 8080 --web-hostname 192.168.1.17

Future<void> main() async {
  Vx.setPathUrlStrategy();
  await Firebase.initializeApp();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationServices>(
          create: (context) => AuthenticationServices(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationServices>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider<AppLanguage>(create: (context) => appLanguage),
        ChangeNotifierProvider<UpdateUI>(create: (context) => UpdateUI()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider())
      ],
      child: Consumer<AppLanguage>(
        builder: (context, model, child) {
          return MaterialApp.router(
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            debugShowCheckedModeBanner: false,
            title:
                'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            routeInformationParser: VxInformationParser(),
            routerDelegate: VxNavigator(
              notFoundPage: (uri, params) => MaterialPage(
                child: NotFoundPage(
                  path: uri.toString(),
                ),
              ),
              routes: {
                '/': (_, __) => MaterialPage(child: LandingPage()),
                MyRoutes.myStatusID: (uri, __) {
                  final myID = uri.queryParameters["id"];
                  return MaterialPage(
                    fullscreenDialog: false,
                    child: MyStatusIDScaffold(
                      mysidData: myID,
                    ),
                  );
                },
                MyRoutes.mySIDDetails: (uri, __) {
                  final catalog = uri.queryParameters["id"];
                  return MaterialPage(
                    fullscreenDialog: false,
                    child: RepairReport(
                      mysid: catalog,
                    ),
                  );
                }
              },
            ),
            locale: model.appLocal,
            supportedLocales: [
              Locale('my', ''),
              Locale('en', 'US'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
