import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class OurServices extends StatelessWidget {
  const OurServices({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          children: [
            SelectableText(
              '${AppLocalizations.of(context).translate('ourservicestitle')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 46,
              ),
            ),
            Container(
              width: 150,
              child: Divider(
                thickness: 1,
              ),
            ),
            SizedBox(height: 10),
            SelectableText(
              '${AppLocalizations.of(context).translate('ourservicessubtitle')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60),
            Wrap(
              spacing: 100,
              runSpacing: 50,
              alignment: WrapAlignment.center,
              children: [
                serviceContaint(
                  kImageLCD,
                  'LCD',
                  '${AppLocalizations.of(context).translate('LCD')}',
                ),
                serviceContaint(
                  kImageBattery,
                  'Battery',
                  '${AppLocalizations.of(context).translate('battery')}',
                ),
                serviceContaint(
                  kImageSoftware,
                  'Software',
                  '${AppLocalizations.of(context).translate('software')}',
                ),
                serviceContaint(
                  kImageSubBoard,
                  'Sub Board',
                  '${AppLocalizations.of(context).translate('subboard')}',
                ),
                serviceContaint(
                  kImageButton,
                  'Button',
                  '${AppLocalizations.of(context).translate('button')}',
                ),
                serviceContaint(
                  kImageWaterDamaged,
                  'Water Damaged',
                  '${AppLocalizations.of(context).translate('waterdamaged')}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container serviceContaint(String url, String title, String subtitle) {
    return Container(
      height: 480,
      width: 300,
      color: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: ExtendedNetworkImageProvider(url),
                height: 200,
                width: double.infinity,
              ),
            ),
            // Image.network(url),
            SizedBox(height: 20),
            SelectableText(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
                fontSize: 25,
              ),
            ),
            SelectableText(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                letterSpacing: 1.1,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
