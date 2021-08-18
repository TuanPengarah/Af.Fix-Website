import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  _launchEmail() async {
    final url = "mailto:$kEmailKedai?,";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xff4D4D4D),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 100,
              runSpacing: 15,
              children: [
                Image(
                  image: AssetImage('assets/images/splash_light.png'),
                  height: 120,
                ),
                Container(
                  width: 800,
                  child: SelectableText(
                    '${AppLocalizations.of(context).translate('fmission')}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Tooltip(
                      message: 'WhatsApp',
                      child: InkWell(
                        onTap: () {
                          html.window.open(kWhatsAppLink, 'WhatsApp');
                        },
                        child: CircleAvatar(
                          minRadius: 25,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          child: Icon(
                            MaterialCommunityIcons.whatsapp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Tooltip(
                      message: 'Facebook',
                      child: InkWell(
                        onTap: () {
                          html.window.open(kFacebookLink, 'Facebook');
                        },
                        child: CircleAvatar(
                          minRadius: 25,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          child: Icon(
                            MaterialCommunityIcons.facebook,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Tooltip(
                      message: 'Instagram',
                      child: InkWell(
                        onTap: () {
                          html.window.open(kInstagramLink, 'Instagram');
                        },
                        child: CircleAvatar(
                          minRadius: 25,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          child: Icon(
                            MaterialCommunityIcons.instagram,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Tooltip(
                      message: 'Email',
                      child: InkWell(
                        onTap: () => _launchEmail(),
                        child: CircleAvatar(
                          minRadius: 25,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          child: Icon(
                            MaterialCommunityIcons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            SelectableText(
              '${AppLocalizations.of(context).translate('copyright')}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
