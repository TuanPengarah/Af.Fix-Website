import 'package:affix_web/config/constant.dart';
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
              backgroundColor: kColorRed,
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
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: kColorRed,
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
