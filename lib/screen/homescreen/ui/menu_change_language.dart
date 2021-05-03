import 'package:affix_web/config/change_lang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showLanguage(BuildContext context) async {
  var appLanguage = Provider.of<AppLanguage>(context, listen: false);
  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(400, 440, 10, 100),
    items: [
      PopupMenuItem<int>(
        value: 0,
        child: Text('Bahasa Melayu'),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: Text('English'),
      ),
    ],
  );
  if (selected == 0) {
    appLanguage.changeLanguage(Locale("my"));
  } else if (selected == 1) {
    appLanguage.changeLanguage(Locale("en"));
  }
}
