import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';

class RepairForm extends StatelessWidget {
  const RepairForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height: 800,
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
