import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  await DialogBackground(
    dismissable: true,
    blur: 6,
    dialog: AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
          '${AppLocalizations.of(context).translate('signoutconfirmtitle')}'),
      content: Text(
          '${AppLocalizations.of(context).translate('signoutconfirmsubtitle')}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '${AppLocalizations.of(context).translate('cancel')}',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        SizedBox(width: 10),
        TextButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await context.read<AuthenticationServices>().signOut().then(
                  (value) => Provider.of<UpdateUI>(context, listen: false)
                      .setUserPhoto(null));
              Navigator.of(context).pop();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${AppLocalizations.of(context).translate('signout')}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.red,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    ),
  ).show(context);
}
