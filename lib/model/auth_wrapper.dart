import 'package:affix_web/screen/homescreen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User>();

    if (_firebaseUser != null) {
      return LandingPage(
        isLogin: true,
      );
    }
    return LandingPage(
      isLogin: false,
    );
  }
}
