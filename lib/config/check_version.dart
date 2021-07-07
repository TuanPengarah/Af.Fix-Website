import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckVersion {
  ScaffoldMessengerState context;
  CheckVersion({this.context});

  Future<bool> checkVersion() async {
    bool isUpdate;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await FirebaseFirestore.instance
          .collection('Version')
          .doc('Web')
          .get()
          .then((e) async {
        double onFirestore = e.data()['version'];
        double version = (prefs.getDouble('webVersion') ?? 0);
        print('local version : $version');
        await prefs.setDouble('webVersion', onFirestore);
        print('on Firestore : $onFirestore');
        if (version != onFirestore) {
          print('New Version Available');
          isUpdate = true;
        } else {
          isUpdate = false;
        }
      });
    } on FirebaseException catch (e) {
      print(e);
      isUpdate = false;
    }
    return isUpdate;
  }
}
