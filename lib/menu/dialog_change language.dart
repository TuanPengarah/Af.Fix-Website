import 'package:affix_web/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

Future<void> showGlobalDialog(
  BuildContext context,
  Function() onPressed,
  String title,
  String subtitle,
) async {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    title: Text('$title'),
    content: Text('$subtitle'),
    actions: [
      TextButton(
        child: Text(
          '${AppLocalizations.of(context).translate('cancel')}',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: Text(
          '${AppLocalizations.of(context).translate('continue')}',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).primaryColor,
          ),
        ),
        onPressed: onPressed,
      ),
    ],
  );
  await DialogBackground(
    blur: 6,
    dialog: alert,
  ).show(context);
}
