import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/snackbar/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    String _year = DateTime.now().year.toString();
    String _uidText = Provider.of<UpdateUI>(context).uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          tooltip: '${AppLocalizations.of(context).translate('buttonclose')}',
          icon: Icon(
            Icons.close,
            color: _isDarkMode == false
                ? Colors.white
                : Provider.of<UpdateUI>(context).changeColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Builder(
            builder: (BuildContext context) => IconButton(
              tooltip: 'Menu',
              icon: Icon(
                Icons.menu,
                color: _isDarkMode == false
                    ? Colors.white
                    : Provider.of<UpdateUI>(context).changeColor,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Container(
                width: 500,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset(
                            _isDarkMode == false
                                ? 'assets/images/splash_light.png'
                                : 'assets/images/splash_dark.png',
                          ),
                        ),
                        SizedBox(height: 20),
                        SelectableText(
                          '${AppLocalizations.of(context).translate('contactustitle')}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(thickness: 1.5),
                        SizedBox(height: 10),
                        ListTile(
                          title: Text('Email'),
                          subtitle: Text(kEmailKedai),
                          leading: Icon(
                            MaterialCommunityIcons.email,
                          ),
                          onTap: () async {
                            final url = "mailto: $kEmailKedai";
                            await Future.delayed(Duration(milliseconds: 180));
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              showErrorSnackBar('Could not launch $url');
                            }
                          },
                        ),
                        ListTile(
                          title: Text(
                              '${AppLocalizations.of(context).translate('calltitle')}'),
                          subtitle: Text('+6011-11796421'),
                          leading: Icon(
                            MaterialCommunityIcons.phone,
                          ),
                          onTap: () async {
                            final url = "tel: $kNoKedai";
                            await Future.delayed(Duration(milliseconds: 180));
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              showErrorSnackBar('Could not launch $url');
                            }
                          },
                        ),
                        ListTile(
                          title: Text(
                              '${AppLocalizations.of(context).translate('messagetitle')}'),
                          subtitle: Text('+6011-11796421'),
                          leading: Icon(
                            MaterialCommunityIcons.message,
                          ),
                          onTap: () async {
                            final url = "sms: $kNoKedai";
                            await Future.delayed(Duration(milliseconds: 180));
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              showErrorSnackBar('Could not launch $url');
                            }
                          },
                        ),
                        ListTile(
                          title: Text(
                              '${AppLocalizations.of(context).translate('webappstitle')}'),
                          subtitle: Text('af-fix.com'),
                          leading: Icon(
                            MaterialCommunityIcons.web,
                          ),
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 300));
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text('Facebook'),
                          subtitle: Text('Af-Fix Smartphone Repair'),
                          leading: Icon(
                            MaterialCommunityIcons.facebook,
                          ),
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 200));
                            html.window.open(kFacebookLink, 'Facebook');
                          },
                        ),
                        ListTile(
                          title: Text('Instagram'),
                          subtitle: Text('@assaff.fix'),
                          leading: Icon(
                            MaterialCommunityIcons.instagram,
                          ),
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 200));
                            html.window.open(kInstagramLink, 'Instagram');
                          },
                        ),
                        ListTile(
                          title: Text('WhatsApp'),
                          subtitle: Text('+6011-11796421'),
                          leading: Icon(
                            MaterialCommunityIcons.whatsapp,
                          ),
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 200));
                            html.window.open(kWhatsAppLink, 'WhatsApp');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              SelectableText(
                '${AppLocalizations.of(context).translate('copyright')} $_year | ${AppLocalizations.of(context).translate('copyright1')}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
