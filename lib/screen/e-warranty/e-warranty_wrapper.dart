import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/e-warranty/e-warranty_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class EwarrantyWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _uidText = Provider.of<UpdateUI>(context).uid;
    bool _isAnony = Provider.of<UpdateUI>(context).checkAnonymous;
    if (_isAnony == true) {
      return NotLoginPage();
    } else if (_isAnony == false) {
      return EwarrantyHome(
        uid: _uidText,
      );
    }
    return NotLoginPage();
  }
}

class NotLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _uidText = Provider.of<UpdateUI>(context).uid;
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Scaffold(
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      imageSignFirst(),
                      content(context: context),
                    ],
                  ),
                ),
              );
            }
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: Column(
                      children: [
                        imageSignFirst(imgSize: 260),
                        content(
                            context: context, fntTitleSize: 30, fntSubSize: 16),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (BuildContext context) => IconButton(
                tooltip: 'Menu',
                icon: Icon(Icons.menu,
                    color: _isDarkMode == true ? kColorGrey : Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (BuildContext context) => IconButton(
                  tooltip: 'Back',
                  icon: Icon(Icons.arrow_back,
                      color: _isDarkMode == true ? kColorGrey : Colors.white),
                  onPressed: () {
                    SystemChrome.setApplicationSwitcherDescription(
                        ApplicationSwitcherDescription(
                      label:
                          'Af-Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
                      primaryColor: Theme.of(context).primaryColor.value,
                    ));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded content(
      {BuildContext context, double fntTitleSize, double fntSubSize}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            '${AppLocalizations.of(context).translate('signinfirst')}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fntTitleSize ?? 45,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 250,
            child: Divider(
              thickness: 3,
            ),
          ),
          SizedBox(height: 10),
          SelectableText(
            '${AppLocalizations.of(context).translate('signinfirstsub')}',
            textAlign: TextAlign.center,
            maxLines: 5,
            style: TextStyle(
              fontSize: fntSubSize ?? 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Wrap(
            runSpacing: 10,
            alignment: WrapAlignment.spaceEvenly,
            runAlignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: SizedBox(
                  height: 50,
                  width: 230,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      VxNavigator.of(context).push(Uri.parse(MyRoutes.login));
                    },
                    icon: Icon(Icons.login),
                    label: Text(
                        '${AppLocalizations.of(context).translate('signin')}'),
                  ),
                ),
              ),
              SizedBox(width: 30),
              TextButton(
                onPressed: () {
                  VxNavigator.of(context).pop();
                },
                child: Text(
                  '${AppLocalizations.of(context).translate('visithelpcenter')}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded imageSignFirst({imgSize}) {
    return Expanded(
      child: Image(
        image: NetworkImage(kImageSignFirst),
        height: imgSize ?? 450,
      ),
    );
  }
}
