import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class WhyAccount extends StatelessWidget {
  final bool isMobile;
  WhyAccount({this.isMobile});
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Container(
      // height: 500,
      width: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SelectableText(
              '${AppLocalizations.of(context).translate('titlecreateacc')}',
              style: TextStyle(
                fontSize: isMobile == true ? 40 : 50,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '${AppLocalizations.of(context).translate('alreadyaccount')} ',
                  style: TextStyle(
                      color: _isDarkMode == true ? kColorGrey : Colors.white),
                ),
                TextSpan(
                    text:
                        '${AppLocalizations.of(context).translate('clickhere')}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pop();
                      }),
              ],
            ),
          ),
          SizedBox(height: 30),
          advantage(
            context: context,
            icon: MaterialCommunityIcons.book_open_outline,
            title: '${AppLocalizations.of(context).translate('advantage1')}',
          ),
          advantage(
            context: context,
            icon: Icons.browser_not_supported_sharp,
            title: '${AppLocalizations.of(context).translate('advantage2')}',
          ),
          advantage(
            context: context,
            icon: Icons.notifications_active,
            title: '${AppLocalizations.of(context).translate('advantage3')}',
          ),
          advantage(
            context: context,
            icon: Icons.history,
            title: '${AppLocalizations.of(context).translate('advantage4')}',
          ),
          advantage(
            context: context,
            icon: MaterialCommunityIcons.sale,
            title: '${AppLocalizations.of(context).translate('advantage5')}',
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Padding advantage({BuildContext context, IconData icon, String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 10),
          isMobile == true
              ? Expanded(
                  child: AutoSizeText(
                    title,
                    overflow: TextOverflow.clip,
                    maxLines: 3,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ],
      ),
    );
  }
}
