import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:velocity_x/velocity_x.dart';

class FollowSocialMedia extends StatelessWidget {
  const FollowSocialMedia({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      // height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runAlignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 80,
          runSpacing: 30,
          children: [
            SelectableText(
              '${AppLocalizations.of(context).translate('followsocmed')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
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
                        color: _isDarkMode == false ? Colors.white : kColorGrey,
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
                        color: _isDarkMode == false ? Colors.white : kColorGrey,
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
                        color: _isDarkMode == false ? Colors.white : kColorGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Tooltip(
                  message:
                      '${AppLocalizations.of(context).translate('buttonsocmed')}',
                  child: InkWell(
                    onTap: () {
                      VxNavigator.of(context).push(Uri.parse(MyRoutes.socmed));
                    },
                    child: CircleAvatar(
                      minRadius: 25,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      child: Icon(
                        MaterialCommunityIcons.dots_horizontal,
                        color: _isDarkMode == false ? Colors.white : kColorGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
