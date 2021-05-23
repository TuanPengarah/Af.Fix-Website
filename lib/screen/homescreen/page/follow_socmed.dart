import 'package:affix_web/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class FollowSocialMedia extends StatelessWidget {
  const FollowSocialMedia({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      // height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runAlignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 80,
          runSpacing: 30,
          children: [
            SelectableText(
              '${AppLocalizations.of(context).translate('followsocmed')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              onPressed: () {},
              icon: Icon(MaterialCommunityIcons.contacts),
              label: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    '${AppLocalizations.of(context).translate('buttonsocmed')}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
