import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class TermsOfServices extends StatefulWidget {
  @override
  _TermsOfServicesState createState() => _TermsOfServicesState();
}

class _TermsOfServicesState extends State<TermsOfServices> {
  bool _isMobile;
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
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          _isMobile = false;
        } else {
          _isMobile = true;
        }
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _isMobile == true ? 18.0 : 350.0,
              vertical: _isMobile == true ? 15 : 18,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    SelectableText(
                      '${AppLocalizations.of(context).translate('termsdesc')}',
                    ),
                    const SizedBox(height: 20),
                    SelectableText(
                      '${AppLocalizations.of(context).translate('repairtermstitle')}',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SelectableText(
                        '${AppLocalizations.of(context).translate('repairterms1')}'),
                    const SizedBox(height: 5),
                    SelectableText(
                        '${AppLocalizations.of(context).translate('repairterms2')}'),
                    const SizedBox(height: 5),
                    SelectableText(
                        '${AppLocalizations.of(context).translate('repairterms3')}'),
                    const SizedBox(height: 5),
                    SelectableText(
                        '${AppLocalizations.of(context).translate('repairterms4')}'),
                    const SizedBox(height: 5),
                    SelectableText(
                        '${AppLocalizations.of(context).translate('repairterms5')}'),
                    const SizedBox(height: 5),
                    SelectableText(
                        '${AppLocalizations.of(context).translate('repairterms6')}'),
                    const SizedBox(height: 5),
                    SelectableText(
                        '${AppLocalizations.of(context).translate('repairterms7')}'),
                    const SizedBox(height: 20),
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
                                    .replace(Uri.parse(MyRoutes.privacy));
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
                    Container(
                      alignment: Alignment.centerRight,
                      child: SelectableText(
                        '${AppLocalizations.of(context).translate('updateon')}: 28-12-2021',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
