import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/page/footer.dart';
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
        child: Column(
          children: [
            Container(
              width: 500,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 190,
                        height: 180,
                        child: Image.asset(
                          _isDarkMode == false
                              ? 'assets/images/logo_only_white.png'
                              : 'assets/images/logo_only_black.png',
                        ),
                      ),
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
            Footer(),
          ],
        ),
      ),
    );
  }
}
