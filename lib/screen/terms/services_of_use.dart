import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsOfServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _uidText = Provider.of<UpdateUI>(context).uid;
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Scaffold(
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      SelectableText(
                        'Terms of Services',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Builder(
              builder: (BuildContext context) => IconButton(
                tooltip: 'Menu',
                icon: Icon(
                  Icons.menu,
                  color: _isDarkMode == false
                      ? Colors.white
                      : Provider.of<UpdateUI>(context).changeColor,
                ),
                onPressed: () async {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
