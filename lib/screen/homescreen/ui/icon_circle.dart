import 'package:affix_web/config/constant.dart';
import 'package:affix_web/menu/menu_settings_dekstop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class IconCircle extends StatelessWidget {
  const IconCircle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message: 'Our Social Media',
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                MaterialCommunityIcons.contacts,
                color: kColorWhite,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Tooltip(
          message: 'Settings',
          child: InkWell(
            onTap: () {
              showSettingMenu(context);
            },
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.settings,
                color: kColorWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
