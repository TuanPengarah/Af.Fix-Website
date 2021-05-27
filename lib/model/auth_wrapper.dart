// import 'package:affix_web/config/change_lang.dart';
// import 'package:affix_web/screen/homescreen/home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AuthenticationWrapper extends StatefulWidget {
//   @override
//   _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
// }

// class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
//   _checkLang() async {
//     Provider.of<AppLanguage>(context, listen: false).checkSave();
//   }

//   @override
//   void initState() {
//     _checkLang();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _firebaseUser = context.watch<User>();

//     if (_firebaseUser != null) {
//       return LandingPage(
//         isLogin: true,
//       );
//     }
//     return LandingPage(
//       isLogin: false,
//     );
//   }
// }
