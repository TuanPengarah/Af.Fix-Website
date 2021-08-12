import 'dart:async';
import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/snackbar/error_snackbar.dart';
import 'package:affix_web/snackbar/sucess_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class OtherButtonSign extends StatelessWidget {
  final String title;
  OtherButtonSign({this.title});

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return SignInButton(
      _isDarkMode == false ? Buttons.Google : Buttons.GoogleDark,
      text: title,
      onPressed: () async {
        CustomProgressDialog progressDialog =
            CustomProgressDialog(context, blur: 15);
        progressDialog.setLoadingWidget(
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
        );
        progressDialog.show();
        await context
            .read<AuthenticationServices>()
            .signToGoogle()
            .then((e) async {
          User user = FirebaseAuth.instance.currentUser;
          if (e == 'popup_closed_by_user') {
            progressDialog.dismiss();
            showErrorSnackBar(
                '${AppLocalizations.of(context).translate('googleloginfailed')}');
          } else if (e == 'newuser') {
            progressDialog.dismiss();
            showSuccessSnackBar(
                '${AppLocalizations.of(context).translate('signinnew')} ${user.displayName}');
            Future.delayed(Duration(seconds: 2), () {
              VxNavigator.of(context).pop();
            });
          } else if (e == 'login') {
            progressDialog.dismiss();
            showSuccessSnackBar(
                '${AppLocalizations.of(context).translate('signincomplete')} ${user.displayName}');
            Future.delayed(Duration(seconds: 2), () {
              VxNavigator.of(context).pop();
            });
          } else {
            progressDialog.dismiss();
            showErrorSnackBar(
                '${AppLocalizations.of(context).translate('googleloginfailed')}: $e');
          }
        });
      },
    );
  }
}
