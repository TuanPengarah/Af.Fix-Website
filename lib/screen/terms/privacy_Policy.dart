import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicy extends StatelessWidget {
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
        title: Text('Privacy Policy'),
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 20),
                  SelectableText(
                    'At Af.Fix Smartphone Repair, accessible from af-fix.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Af.Fix Smartphone Repair and how we use it. If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us. This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Af.Fix Smartphone Repair. This policy is not applicable to any information collected offline or via channels other than this website.',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    'Consent',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    'By using our website, you hereby consent to our Privacy Policy and agree to its terms.',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    'Information we collect',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    'The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information. If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide. When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.',
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    'How we use your information',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                      'We use the information we collect in various ways, including to:'),
                  SizedBox(height: 10),
                  SelectableText(
                      '• Provide, operate, and maintain our website'),
                  SizedBox(height: 10),
                  SelectableText(
                      '• Improve, personalize, and expand our website'),
                  SizedBox(height: 10),
                  SelectableText(
                      '• Understand and analyze how you use our website'),
                  SizedBox(height: 10),
                  SelectableText(
                      '• Develop new products, services, features, and functionality'),
                  SizedBox(height: 10),
                  SelectableText(
                      '• Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website, and for marketing and promotional purposes'),
                  SizedBox(height: 10),
                  SelectableText('• Send you emails'),
                  SizedBox(height: 10),
                  SelectableText('• Find and prevent fraud'),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
