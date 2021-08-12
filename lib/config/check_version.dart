import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/homescreen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckVersion {
  Future<bool> checkVersion(BuildContext context) async {
    bool _isAnony =
        Provider.of<UpdateUI>(context, listen: false).checkAnonymous;
    bool isUpdate;
    if (_isAnony != true && FirebaseAuth.instance.currentUser != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        await FirebaseFirestore.instance
            .collection('Version')
            .doc('Web')
            .get()
            .then((e) async {
          double onFirestore = e.data()['version'];

          double version = (prefs.getDouble('webVersion') ?? 0);

          if (version != onFirestore) {
            print('New Version Available');
            setVersion = e.data()['version'];
            isUpdate = true;
          } else {
            isUpdate = false;
          }
        });
      } on FirebaseException catch (e) {
        print(e);
        isUpdate = false;
      }
    } else {
      isUpdate = false;
    }
    return isUpdate;
  }
}
