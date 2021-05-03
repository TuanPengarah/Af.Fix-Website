import 'package:affix_web/config/themeUI_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showDarkTheme(BuildContext context) async {
  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(400, 490, 9, 100),
    items: [
      PopupMenuItem<int>(
        value: 0,
        child: Text('On'),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: Text('Off'),
      ),
    ],
  );
  if (selected == 0) {
    print('dark theme on');
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(true);
  } else if (selected == 1) {
    print('dark theme off');
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(false);
  }
}
