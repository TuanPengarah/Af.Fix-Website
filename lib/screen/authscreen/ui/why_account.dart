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
          SelectableText(
            'Let\'s create your account!',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                      color: _isDarkMode == true ? kColorGrey : Colors.white),
                ),
                TextSpan(
                    text: 'Click here',
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
            title: 'Get access to all your warranty status',
          ),
          advantage(
            context: context,
            icon: Icons.browser_not_supported_sharp,
            title: 'Track your repair status without entering MySID',
          ),
          advantage(
            context: context,
            icon: Icons.notifications_active,
            title: 'Get notified when your devices is ready to pickup',
          ),
          advantage(
            context: context,
            icon: Icons.history,
            title: 'Access to all your devices repair history',
          ),
          advantage(
            context: context,
            icon: MaterialCommunityIcons.sale,
            title: 'Get a discounted price on each repair',
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
