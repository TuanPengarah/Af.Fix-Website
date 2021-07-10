import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/main.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/snackbar/sucess_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

Future<void> changePassword({BuildContext context}) async {
  final _inputOldPass = TextEditingController();
  final _inputNewPass = TextEditingController();
  bool _errOldPassword = false;
  bool _errNewPassword = false;
  bool _showPassword = true;
  Provider.of<AuthenticationServices>(context, listen: false).isError = false;
  Provider.of<AuthenticationServices>(context, listen: false).getError('');
  await DialogBackground(
    dismissable: true,
    blur: 6,
    dialog: StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Center(
          child: Text(
            '${AppLocalizations.of(context).translate('titlechangepassword')}',
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
              TextField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                controller: _inputOldPass,
                obscureText: _showPassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10),
                  labelText:
                      '${AppLocalizations.of(context).translate('oldpassword')}',
                  alignLabelWithHint: true,
                  errorText: _errOldPassword == true
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
                      '${AppLocalizations.of(context).translate('defaultpassword')}123456',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _showPassword,
                controller: _inputNewPass,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10),
                  labelText:
                      '${AppLocalizations.of(context).translate('newpassword')}',
                  alignLabelWithHint: true,
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
                  errorText: _errNewPassword == true
                      ? '${AppLocalizations.of(context).translate('pleasepassword')}'
                      : null,
                  hintText:
                      '${AppLocalizations.of(context).translate('pleasepassword')}',
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
                    onPressed: () {
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
                        _errNewPassword = false;
                        _errOldPassword = false;
                      });

                      if (_inputNewPass.text.isEmpty) {
                        setState(() {
                          _errOldPassword = true;
                        });
                      } else {
                        await _submitting(
                                context, _inputOldPass.text, _inputNewPass.text)
                            .then(
                          (value) {
                            if (value == 'wrong-password') {
                              setState(() {
                                _errOldPassword = true;
                              });
                              Provider.of<AuthenticationServices>(context,
                                      listen: false)
                                  .isError = false;
                              Provider.of<AuthenticationServices>(context,
                                      listen: false)
                                  .getError('');
                            } else if (value == 'weak-password') {
                              setState(() {
                                _errNewPassword = true;
                              });
                              Provider.of<AuthenticationServices>(context,
                                      listen: false)
                                  .isError = false;
                              Provider.of<AuthenticationServices>(context,
                                      listen: false)
                                  .getError('');
                            } else if (value == null || value == '') {
                              Provider.of<AuthenticationServices>(context,
                                      listen: false)
                                  .isError = false;
                              Provider.of<AuthenticationServices>(context,
                                      listen: false)
                                  .getError('');
                              print('Successfully Changing Password');
                              showSuccessSnackBar(
                                  '${AppLocalizations.of(context).translate('ok-change-password')}');
                              Navigator.of(context).pop();
                            } else {
                              Provider.of<AuthenticationServices>(context,
                                      listen: false)
                                  .isError = false;
                              Provider.of<AuthenticationServices>(context,
                                      listen: false)
                                  .getError('');
                              print('Error $value');
                              navigatorKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    '${AppLocalizations.of(context).translate('submit')}',
                                    style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.amber[900],
                              ));
                              Navigator.of(context).pop();
                            }
                          },
                        );
                      }
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
}

Future<String> _submitting(
    BuildContext context, String oldPassword, String newPassword) async {
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
      .reauthUser(user.email, oldPassword)
      .then((value) async {
    status = value;
    bool isError =
        Provider.of<AuthenticationServices>(context, listen: false).isError;
    if (isError == true) {
      progressDialog.dismiss();
    } else {
      await context
          .read<AuthenticationServices>()
          .updatePassword(newPassword)
          .then((value) {
        return status = value;
      });

      await user.reload();
      progressDialog.dismiss();
    }
  });
  return status;
}
