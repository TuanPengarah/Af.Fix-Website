import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorRed,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 20.0),
                child: SelectableText(
                  '${AppLocalizations.of(context).translate('whyus')}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 40,
                  ),
                ),
              ),
              Container(
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 80),
              Wrap(
                spacing: 100,
                runSpacing: 50,
                alignment: WrapAlignment.center,
                children: [
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('cheap')}',
                    kImageMoney,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('bmf')}',
                    kImageMalaysia,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('mailin')}',
                    kImageCourier,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('services')}',
                    kImageService,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('diagnostic')}',
                    kImageChecking,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('system')}',
                    kImageSystem,
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Container aboutContaint(String title, String url) {
    return Container(
      height: 450,
      width: 300,
      color: Colors.black.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(url),
            ),
            SizedBox(height: 15),
            SelectableText(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                fontSize: 20,
                color: kColorWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
