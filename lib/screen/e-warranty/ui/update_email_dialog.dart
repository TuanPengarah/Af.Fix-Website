import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/model/update_user_info.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

Future<void> updatingEmail({BuildContext context, String defaultEmail}) async {
  final _inputPass = TextEditingController();
  final _inputEmail = TextEditingController();
  bool _errEmail = false;

  bool _showPassword = true;
  Provider.of<AuthenticationServices>(context, listen: false).isError = false;
  Provider.of<AuthenticationServices>(context, listen: false).getError('');
  await DialogBackground(
    dismissable: true,
    blur: 16,
    dialog: StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Update your email address',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                    text:
                        'Please insert your new email address and your password to continue, your current email address is ',
                    children: [
                      TextSpan(
                        text: '$defaultEmail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                controller: _inputEmail,
                decoration: InputDecoration(
                  errorText: _errEmail == true
                      ? 'Please enter correct email address'
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
                  hintText: 'New email address',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _showPassword,
                controller: _inputPass,
                decoration: InputDecoration(
                  focusColor: Theme.of(context).primaryColor,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  hintText: 'Enter your password',
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
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (!isEmail(_inputEmail.text) || _inputEmail.text.isEmpty) {
                setState(() {
                  _errEmail = true;
                });
              } else {
                _submitting(context, _inputEmail.text, _inputPass.text).then(
                  (value) => Navigator.of(context).pop(),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Submit',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15),
              ),
            ),
          ),
        ],
      );
    }),
  ).show(context);
}

Future<void> _submitting(
    BuildContext context, String email, String password) async {
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
    print('reauth completed');
  });

  await user.updateEmail(email);
  await FirebaseFirestore.instance.collection('customer').doc(user.uid).update({
    'Email': email,
  });
  print('Successfully Update Email');
  await user.reload();
  progressDialog.dismiss();
}
