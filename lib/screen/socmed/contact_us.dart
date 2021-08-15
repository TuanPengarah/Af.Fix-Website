import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/page/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

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
                          'assets/images/logo_only_white.png',
                        ),
                      ),
                      SelectableText(
                        'Jom Hubungi Kami!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Email'),
                        subtitle: Text('services.af.fix@gmail.com'),
                        leading: Icon(
                          MaterialCommunityIcons.email,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Call'),
                        subtitle: Text('+6011-11796421'),
                        leading: Icon(
                          MaterialCommunityIcons.phone,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Message'),
                        subtitle: Text('+6011-11796421'),
                        leading: Icon(
                          MaterialCommunityIcons.message,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Web Apps'),
                        subtitle: Text('af-fix.com'),
                        leading: Icon(
                          MaterialCommunityIcons.web,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Facebook'),
                        subtitle: Text('Af-Fix Smartphone Repair'),
                        leading: Icon(
                          MaterialCommunityIcons.facebook,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Instagram'),
                        subtitle: Text('@assaff.fix'),
                        leading: Icon(
                          MaterialCommunityIcons.instagram,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('WhatsApp'),
                        subtitle: Text('+6011-11796421'),
                        leading: Icon(
                          MaterialCommunityIcons.whatsapp,
                        ),
                        onTap: () {},
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
