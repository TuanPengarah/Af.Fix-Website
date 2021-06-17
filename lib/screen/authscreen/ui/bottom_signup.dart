import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

showBottomSignUp(BuildContext context) {
  showFlexibleBottomSheet(
      context: context,
      minHeight: 0,
      initHeight: 0.8,
      maxHeight: 0.9,
      builder: (
        BuildContext context,
        ScrollController scrollController,
        double bottomSheetOffset,
      ) {
        return Material(
          child: Column(
            children: [Text('Create account')],
          ),
        );
      });
}
