import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool _isMobile = false;
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
        title:
            Text('${AppLocalizations.of(context).translate('privacypolicy')}'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('privacydesc2')}',
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('consenttitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('consentdesc')}',
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('infocollecttitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('infocollectdesc')}',
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('howwetitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('howwedesc1')}'),
                      SizedBox(height: 10),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('howwedesc2')}'),
                      SizedBox(height: 10),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('howwedesc3')}'),
                      SizedBox(height: 10),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('howwedesc4')}'),
                      SizedBox(height: 10),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('howwedesc5')}'),
                      SizedBox(height: 10),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('howwedesc6')}'),
                      SizedBox(height: 10),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('howwedesc7')}'),
                      SizedBox(height: 10),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('howwedesc8')}'),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('logtitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('logdesc')}',
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('adpartnertitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('adpartnerdesc')}',
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('thirdtitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('thirddesc')}',
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('ccpatitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                          '${AppLocalizations.of(context).translate('ccpadesc1')}'),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('ccpadesc2')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('ccpadesc3')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('ccpadesc4')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('ccpadesc5')}',
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gdprtitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gpdrdesc1')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gpdrdesc2')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gpdrdesc3')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gpdrdesc4')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gpdrdesc5')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gpdrdesc6')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gpdrdesc7')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('gpdrdesc8')}',
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('childrentitle')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('childrendesc1')}',
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('childrendesc2')}',
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
          ),
        );
      }),
    );
  }
}
