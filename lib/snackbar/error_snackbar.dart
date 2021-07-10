import 'package:affix_web/main.dart';
import 'package:flutter/material.dart';

showErrorSnackBar(String title) {
  navigatorKey.currentState.showSnackBar(
    SnackBar(
      content: Text(
        title ?? 'Aw Snap, An error occured, please try again later!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.amber[900],
    ),
  );
}
