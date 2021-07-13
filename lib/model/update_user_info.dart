import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/snackbar/sucess_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

import 'package:provider/provider.dart';

Future<void> updateUser({
  @required BuildContext context,
  @required String inputPhone,
  @required String inputName,
}) async {
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
  print('Updating user data..');
  print(inputName);
  print(inputPhone);
  User user = FirebaseAuth.instance.currentUser;
  var firestoreCollection =
      FirebaseFirestore.instance.collection('customer').doc(user.uid);
  //Update Name dan Phone Number di  Firestore
  await firestoreCollection.update({
    'Nama': inputName,
    'No Phone': inputPhone,
  });

  //Update User Auth Name
  await user.updateDisplayName(inputName);
  //Update Email
  // await context.read<AuthenticationServices>().updateEmail(inputEmail);
  // if (Provider.of<AuthenticationServices>(context, listen: false).status ==
  //     'requires-recent-login') {
  //   await reauthUserDialog();
  // }
  Provider.of<UpdateUI>(context, listen: false).setUserName(inputName);
  await user.reload().then((value) {
    print('Updating completed');
    progressDialog.dismiss();
    showSuccessSnackBar(
        '${AppLocalizations.of(context).translate('updatecomplete')}');
  });
}
