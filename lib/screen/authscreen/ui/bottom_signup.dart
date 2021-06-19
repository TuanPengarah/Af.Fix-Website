import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/screen/authscreen/ui/register_form.dart';
import 'package:affix_web/screen/authscreen/ui/why_account.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showBottomSignUp(BuildContext context) {
  bool _isMobile = false;
  bool _isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDark;
  return showFlexibleBottomSheet(
      context: context,
      minHeight: 0,
      initHeight: 0.8,
      maxHeight: 1,
      builder: (
        BuildContext context,
        ScrollController scrollController,
        double bottomSheetOffset,
      ) {
        return Material(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  _isMobile = false;
                  return CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 20),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                WhyAccount(isMobile: _isMobile),
                                SizedBox(width: 50),
                                RegisterForm(isMobile: _isMobile),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  _isMobile = true;
                  return ListView(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30 * 2.0, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            WhyAccount(isMobile: _isMobile),
                            RegisterForm(isMobile: _isMobile),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (BuildContext context) => IconButton(
                    tooltip:
                        '${AppLocalizations.of(context).translate('buttonclose')}',
                    icon: Icon(Icons.close,
                        color: _isDarkMode == true ? kColorGrey : Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
