import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AuthenticationServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuthWeb;
  String status = 'Sign in completed!';
  bool isError = false;
  AuthenticationServices(this._firebaseAuthWeb);

  getError(String e) {
    status = e;
    notifyListeners();
  }

  Future<void> signOut() async {
    print('signing out...');
    await _firebaseAuthWeb.signOut();
  }

  Future<String> getUID() async {
    final user = _firebaseAuthWeb.currentUser;
    final uid = user.uid;
    return uid;
  }

  Future<String> getUserName() async {
    final user = _firebaseAuthWeb.currentUser;
    final userName = user.displayName;
    return userName;
  }

  Future<String> getUserPhoto() async {
    final user = _firebaseAuthWeb.currentUser;
    final userPhoto = user.photoURL;

    return userPhoto;
  }

  Future<String> getEmail() async {
    final user = _firebaseAuthWeb.currentUser;
    final email = user.email;
    return email;
  }

  Future<String> anonymousSignIn() async {
    try {
      await _firebaseAuthWeb.signInAnonymously();
      return 'Sign in Anonymously!';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuthWeb.signInWithEmailAndPassword(
          email: email, password: password);
      isError = false;
      getError('Sign in completed!');
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        getError('User not found! Please check your email address');
        isError = true;
        return 'no user';
      } else if (e.code == 'wrong-password') {
        getError('Wrong Password!');
        isError = true;
        return 'wrong password';
      }
      isError = true;
      getError(e.message);
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuthWeb.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed up';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<void> linktoGoogle() async {
    User _user = _firebaseAuthWeb.currentUser;
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _user.linkWithCredential(credential).then((value) {
      _user.updateProfile(
          displayName: googleUser.displayName, photoURL: googleUser.photoUrl);
    });
  }

  Future<void> signToGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      isError = false;
      return await _firebaseAuthWeb.signInWithCredential(credential);
    } on PlatformException catch (e) {
      isError = true;
      if (e.code == 'popup_closed_by_user') {
        getError('Sign in failed!');
      }
      // getError(e.toString());
    }
  }

  Future<void> createUserData() async {
    User _user = _firebaseAuthWeb.currentUser;
    String tarikh = '';
    // String tarikh() {
    //   var now = new DateTime.now();
    //   var formatter = new DateFormat('dd-MM-yyyy');
    //   return formatter.format(now);
    // }

    //fungsi search (LOOP Method)
    List<String> splitList = _user.displayName.split(" ");
    List<String> indexList = [];
    for (int i = 0; i < splitList.length; i++) {
      for (int y = 1; y < splitList[i].length + 1; y++)
        indexList.add(splitList[i].substring(0, y).toLowerCase());
    }
    var now = DateTime.now();
    var formatter = new DateFormat('dd-M-yyyy');
    tarikh = formatter.format(now);
    Map<String, dynamic> createUser = {
      'Tarikh': tarikh,
      'Nama': '${_user.displayName}',
      'No Phone': '${_user.phoneNumber}',
      'Email': '${_user.email}',
      'Search Index': indexList,
    };
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(_user.uid)
        .set(createUser)
        .then(
            (value) => print('User has been succesfully created on database!'));
  }
}
