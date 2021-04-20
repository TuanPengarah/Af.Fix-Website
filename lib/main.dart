import 'package:affix_web/config/routes.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:affix_web/screen/myrepairid.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
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
    );
  }
}
