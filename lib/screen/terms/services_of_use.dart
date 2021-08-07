import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class TermsOfServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _uidText = Provider.of<UpdateUI>(context).uid;
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
          ),
        ),
        title: Text('${AppLocalizations.of(context).translate('termstitle')}'),
        actions: [
          Builder(
            builder: (BuildContext context) => IconButton(
              tooltip: 'Menu',
              icon: Icon(
                Icons.menu,
              ),
              onPressed: () async {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: Container(
        width: double.infinity,
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('termsdesc')}',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('licensetitle')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('licensedesc')}',
                  ),
                  SizedBox(height: 8),
                  SelectableText(
                      '${AppLocalizations.of(context).translate('licensedesc1')}'),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('licensedesc2')}',
                  ),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('licensedesc3')}',
                  ),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('licensedesc4')}',
                  ),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('licensedesc5')}',
                  ),
                  SizedBox(height: 8),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('licensedesc6')}',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('disclaimertitle')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('disclaimerdesc')}',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('limitationtitle')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('limitationdesc')}',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('revisiontitle')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('revisiondesc')}',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('linkstitle')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('linksdesc')}',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('sitetermstitle')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('sitetermsdesc')}',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('privacytitle')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText.rich(
                    TextSpan(
                      text:
                          '${AppLocalizations.of(context).translate('privacydesc')} ',
                      children: [
                        TextSpan(
                          text:
                              '${AppLocalizations.of(context).translate('privacypolicy')}',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              VxNavigator.of(context)
                                  .push(Uri.parse(MyRoutes.privacy));
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('lawtitle')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('lawdesc')}',
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
