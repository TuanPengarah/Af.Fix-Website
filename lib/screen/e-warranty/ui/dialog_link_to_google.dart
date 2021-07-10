import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/snackbar/error_snackbar.dart';
import 'package:affix_web/snackbar/sucess_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

Future<bool> linkToGoogle(BuildContext context) async {
  final _inputPass = TextEditingController();
  bool _errPassword = false;
  bool _showPassword = true;
  bool done = false;
  void refreshError() {
    Provider.of<AuthenticationServices>(context, listen: false).isError = false;
    Provider.of<AuthenticationServices>(context, listen: false).getError('');
  }

  await DialogBackground(
    dismissable: true,
    blur: 6,
    dialog: StatefulBuilder(builder: (context, setState) {
      refreshError();
      return AlertDialog(
        title: Center(
          child: Text(
            '${AppLocalizations.of(context).translate('titlelinkgoogle')}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText(
                '${AppLocalizations.of(context).translate('subtitlelinkgoogle')}',
                textAlign: TextAlign.center,
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                controller: _inputPass,
                obscureText: _showPassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10),
                  alignLabelWithHint: true,
                  errorText: _errPassword == true
                      ? '${AppLocalizations.of(context).translate('wrongpassword')}'
                      : null,
                  focusColor: Theme.of(context).primaryColor,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber[900],
                    ),
                  ),
                  hintText:
                      '${AppLocalizations.of(context).translate('defaultpassword')}12345',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: !_showPassword,
                    onChanged: (newValue) {
                      setState(() {
                        _showPassword = !newValue;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${AppLocalizations.of(context).translate('showpassword')}',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '${AppLocalizations.of(context).translate('cancel')}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        _errPassword = false;
                      });
                      await _submitting(context, _inputPass.text).then((e) {
                        if (e == 'wrong-password') {
                          setState(() {
                            _errPassword = true;
                          });
                        } else if (e == 'email-already-in-use') {
                          showErrorSnackBar(
                              '${AppLocalizations.of(context).translate('err-email-already-in-use')}');
                          refreshError();
                          Navigator.of(context).pop();
                        } else if (e == 'invalid-email') {
                          showErrorSnackBar(
                              '${AppLocalizations.of(context).translate('err-invalid-email')}');
                          refreshError();
                          Navigator.of(context).pop();
                        } else if (e == 'provider-already-linked') {
                          showErrorSnackBar(
                              '${AppLocalizations.of(context).translate('err-provider-already-linked')}');
                          refreshError();
                          Navigator.of(context).pop();
                        } else if (e == 'invalid-credential') {
                          showErrorSnackBar(
                              '${AppLocalizations.of(context).translate('err-invalid-credential')}');
                          refreshError();
                          Navigator.of(context).pop();
                        } else if (e == 'credential-already-in-use') {
                          showErrorSnackBar(
                              '${AppLocalizations.of(context).translate('err-credential-already-in-use')}');
                          refreshError();
                          Navigator.of(context).pop();
                        } else {
                          refreshError();
                          done = true;
                          showSuccessSnackBar(
                              '${AppLocalizations.of(context).translate('ok-link-google')}');
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '${AppLocalizations.of(context).translate('submit')}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }),
  ).show(context);
  return done;
}

Future<String> _submitting(BuildContext context, String password) async {
  String status;
  CustomProgressDialog progressDialog = CustomProgressDialog(context, blur: 15);
  progressDialog.setLoadingWidget(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
        SizedBox(height: 10),
        Text(
          '${AppLocalizations.of(context).translate('updatinguser')}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
  progressDialog.show();
  User user = FirebaseAuth.instance.currentUser;
  await context
      .read<AuthenticationServices>()
      .reauthUser(user.email, password)
      .then((value) async {
    status = value;
    bool isError =
        Provider.of<AuthenticationServices>(context, listen: false).isError;
    if (isError == true) {
      progressDialog.dismiss();
    } else {
      await context
          .read<AuthenticationServices>()
          .linktoGoogle()
          .then((value) => status = value);
      await user.reload();
      progressDialog.dismiss();
    }
  });
  return status;
}
