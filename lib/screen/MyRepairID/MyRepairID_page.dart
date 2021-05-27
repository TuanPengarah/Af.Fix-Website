import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRepairIDContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _inputSearch = TextEditingController();
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(kImageTicket),
              height: 240,
            ),
            SelectableText(
              '${AppLocalizations.of(context).translate('trackyourrepair')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10),
            SelectableText(
              '${AppLocalizations.of(context).translate('tyrsubtitle')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: 230,
              child: TextField(
                controller: _inputSearch,
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  filled: true,
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10),
                  labelText:
                      '${AppLocalizations.of(context).translate('tyrhint')}',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  // enabledBorder: InputBorder.none,
                  // focusedBorder: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: _isDarkMode
                            ? Colors.teal.shade700
                            : Colors.red.shade800,
                        width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
