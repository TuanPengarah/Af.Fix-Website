import 'package:affix_web/main.dart';
import 'package:flutter/material.dart';

showSuccessSnackBar(String title) {
  navigatorKey.currentState.showSnackBar(
    SnackBar(
      content: Text(
        title ?? 'Congratulations! Operation Completed',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
    ),
  );
}
