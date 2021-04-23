import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/config/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:affix_web/screen/myrepairid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'config/change_lang.dart';

//  flutter run -d web-server --web-port 8080 --web-hostname 192.168.1.17
void main() async {
  setPathUrlStrategy();
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
        ChangeNotifierProvider<AppLanguage>(create: (context) => appLanguage),
        ChangeNotifierProvider<UpdateUI>(create: (context) => UpdateUI())
      ],
      child: Consumer<AppLanguage>(
        builder: (context, model, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title:
                'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            routeInformationParser: VxInformationParser(),
            routerDelegate: VxNavigator(
              routes: {
                '/': (_, __) => MaterialPage(child: LandingPage()),
                MyRoutes.myRepairID: (_, __) =>
                    MaterialPage(child: MyRepairIDDisplay()),
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
