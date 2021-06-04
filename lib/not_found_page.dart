import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class NotFoundPage extends StatelessWidget {
  final String path;
  NotFoundPage({this.path});
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    String _uidText = Provider.of<UpdateUI>(context).uid;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.network(
                  'https://assets4.lottiefiles.com/packages/lf20_ukmmbtae.json'),
              SizedBox(height: 50),
              SelectableText(
                'DEAD END..',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20),
              SelectableText(
                  'Oppps! That page $path you are looking for does not exists')
            ],
          ),
        ),
      ),
    );
  }
}
