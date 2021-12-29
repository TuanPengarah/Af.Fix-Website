import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/screen/authscreen/ui/register_form.dart';
import 'package:affix_web/screen/authscreen/ui/why_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

Future<void> showBottomSignUp(BuildContext context) {
  bool _isMobile = false;
  bool _isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDark;
  return showSlidingBottomSheet(context, builder: (context) {
    return SlidingSheetDialog(
        color: Theme.of(context).canvasColor,
        duration: Duration(milliseconds: 400),
        snapSpec: SnapSpec(snappings: [1, 1]),
        elevation: 8,
        builder: (context, state) {
          return Material(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth > 1200) {
                    _isMobile = false;
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: CustomScrollView(
                        shrinkWrap: true,
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
                      ),
                    );
                  } else {
                    _isMobile = true;
                    return ListView(
                      shrinkWrap: true,
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
                          color:
                              _isDarkMode == true ? kColorGrey : Colors.white),
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
  });
}
