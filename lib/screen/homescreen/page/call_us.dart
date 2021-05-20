import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CallUs extends StatelessWidget {
  const CallUs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _launchCaller() async {
      final url = "tel: $kNoKedai";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Container(
          // height: 400,
          // width: double.infinity,
          decoration: BoxDecoration(
            color: _isDarkMode ? Theme.of(context).primaryColor : kColorGrey,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.spaceAround,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 80,
                runSpacing: 80,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SelectableText(
                        '${AppLocalizations.of(context).translate('call')}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 25),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('callnow')}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.phone,
                    ),
                    label: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '011-11426421',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        _isDarkMode
                            ? Theme.of(context).primaryColor
                            : kColorGrey,
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kColorWhite),
                    ),
                    onPressed: () {
                      _launchCaller();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
