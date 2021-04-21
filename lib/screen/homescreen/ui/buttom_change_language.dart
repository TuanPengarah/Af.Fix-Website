import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:affix_web/config/change_lang.dart';
import 'package:provider/provider.dart';

showLanguageUI(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (c) {
        var appLanguage = Provider.of<AppLanguage>(context);
        return BlurryContainer(
          blur: 10,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          bgColor: kColorWhite,
          child: Column(
            children: [
              Divider(
                indent: 600,
                endIndent: 600,
                thickness: 5,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                '${AppLocalizations.of(context).translate('language')}',
                style: TextStyle(
                  fontSize: 30,
                  color: kColorGrey,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  appLanguage.changeLanguage(Locale("my"));
                  // Navigator.of(context).pop();
                },
                child: Text(
                  'Bahasa Melayu',
                  style: kTextSubtitleDark,
                ),
              ),
              TextButton(
                onPressed: () {
                  appLanguage.changeLanguage(Locale("en"));
                  // Navigator.of(context).pop();
                },
                child: Text(
                  'English',
                  style: kTextSubtitleDark,
                ),
              ),
            ],
          ),
        );
      });
}
