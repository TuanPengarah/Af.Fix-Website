import 'dart:async';

import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/screen/authscreen/ui/bottom_signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class OtherButtonSign extends StatelessWidget {
  final String title;
  final IconData icon;
  final int buttonItem;

  OtherButtonSign({this.title, this.icon, this.buttonItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
          icon: Icon(icon),
          label: Text('$title'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              buttonItem == 0
                  ? Theme.of(context).primaryColor
                  : Colors.blueGrey[800],
            ),
          ),
          onPressed: () async {
            if (buttonItem == 0) {
              CustomProgressDialog progressDialog =
                  CustomProgressDialog(context, blur: 15);
              progressDialog.setLoadingWidget(
                CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );

              await context.read<AuthenticationServices>().signToGoogle();

              User _user = FirebaseAuth.instance.currentUser;
              if (_user != null) {
                progressDialog.show();

                await FirebaseFirestore.instance
                    .collection('customer')
                    .doc(_user.uid)
                    .get()
                    .then((doc) {
                  if (doc.exists) {
                    progressDialog.dismiss();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${AppLocalizations.of(context).translate('signincomplete')}'),
                      ),
                    );
                    Timer(Duration(seconds: 2), () {
                      VxNavigator.of(context).pop();
                    });
                  } else {
                    context
                        .read<AuthenticationServices>()
                        .createUserData()
                        .then((value) {
                      progressDialog.dismiss();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${AppLocalizations.of(context).translate('signinnew')} ${_user.displayName}'),
                        ),
                      );
                      Timer(Duration(seconds: 2), () {
                        VxNavigator.of(context).pop();
                      });
                    });
                  }
                });
              } else if (Provider.of<AuthenticationServices>(context,
                          listen: false)
                      .isError ==
                  true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.amber[900],
                    content: Text(
                      Provider.of<AuthenticationServices>(context,
                              listen: false)
                          .status,
                    ),
                  ),
                );
              }
            } else if (buttonItem == 1) {
              showBottomSignUp(context);
              print('SubhanAllah');
            }
          }),
    );
  }
}
