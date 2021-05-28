import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/MyStatusID/MyStatusID_wrapper.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'config/change_lang.dart';
import 'provider/themeUI_provider.dart';

//flutter run -d web-server --web-port 8080 --web-hostname 192.168.1.17

Future<void> main() async {
  setPathUrlStrategy();
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
              routes: {
                '/': (_, __) => MaterialPage(child: LandingPage()),
                MyRoutes.myRepairID: (_, __) =>
                    MaterialPage(child: MyrepairIDWrapper()),
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
