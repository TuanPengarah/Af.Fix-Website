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
    String userPhoto;
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(user.uid)
        .get()
        .then((f) async {
      userPhoto = await f.data()['photoURL'];
      if (userPhoto == '') {
        userPhoto = null;
      }
    });
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
    String result;
    try {
      await _firebaseAuthWeb.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = e.code;
      } else if (e.code == 'wrong-password') {
        result = e.code;
      } else {
        result = e.code;
      }
    }
    return result;
  }

  Future<String> signUp(
      {String email, String password, String name, String phone}) async {
    String result;
    try {
      await _firebaseAuthWeb
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) async {
        await credential.user.updateDisplayName(name);
        await createUserData(phone, '');
      });
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        isError = true;
        getError('Password is to weak');
        result = e.code;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        isError = true;
        getError(e.message);
        result = e.code;
      }

      isError = true;
      getError(e.message);
      print(e.code);
      return e.message;
    }
    return result;
  }

  Future<String> linktoGoogle() async {
    String result;
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
    try {
      await _user.linkWithCredential(credential).then((newUser) async {
        await newUser.user.updateDisplayName(
          googleUser.displayName,
        );
        await newUser.user.updatePhotoURL(googleUser.photoUrl);
        try {
          await newUser.user.updateEmail(googleUser.email).then((value) async {
            FirebaseFirestore.instance
                .collection('customer')
                .doc(newUser.user.uid)
                .update({
              'Nama': googleUser.displayName,
              'Email': googleUser.email,
              'photoURL': googleUser.photoUrl
            });
            newUser.user
                .reload()
                .then((value) => print('Sucessfully link to Google'));
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-email') {
            print(e.code);
            result = e.code;
            isError = true;
          }
          if (e.code == 'email-already-in-use') {
            print(e.code);
            result = e.code;
            isError = true;
          }
          if (e.code == 'requires-recent-login') {
            result = e.code;
            isError = true;
          }
          result = e.code;
          print(e.code);
          isError = true;
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'provider-already-linked') {
        print(e.code);
        result = e.code;
        isError = true;
      }
      if (e.code == 'invalid-credential') {
        print(e.code);
        result = e.code;
        isError = true;
      }

      if (e.code == 'credential-already-in-use') {
        result = e.code;
        print(e.code);
        isError = true;
      }
      if (e.code == 'email-already-in-use') {
        result = e.code;
        print(e.code);
        isError = true;
      }
      if (e.code == 'invalid=email') {
        result = e.code;
        print(e.code);
        isError = true;
      }
    }
    return result;
  }

  Future<String> reauthUser(String email, String password) async {
    String status;
    User user = _firebaseAuthWeb.currentUser;
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        status = e.code;
        isError = true;
        print(e.code);
        getError(
            'This email is invalid. You must use your Assaff Account email address');
      }
      if (e.code == 'user-mismatch') {
        status = e.code;
        isError = true;
        print(e.code);
        getError(
            'User is mismatch. Please enter your valid proper user account');
      }
      if (e.code == 'wrong-password') {
        status = e.code;
        isError = true;
        print(e.code);
        getError('Wrong Password! Please enter your correct password');
      }
      isError = true;
      status = e.code;
      print(e.code);
      getError(e.code);
    }
    return status;
  }

  Future<void> updateEmail(String newEmail) async {
    User user = _firebaseAuthWeb.currentUser;
    try {
      await user.updateEmail(newEmail);
      print('update email to : $newEmail');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        isError = true;
        print(e.code);
        getError('This email is invalid try use other email address');
      }
      if (e.code == 'email-already-in-use') {
        isError = true;
        print(e.code);
        getError(
            'This email address has been used on another user, try use another email address');
      }
      if (e.code == 'requires-recent-login') {
        isError = true;
        print(e.code);
        getError(e.code);
      }
      isError = true;
      print(e.code);
      getError(e.code);
    }
  }

  Future<String> updatePassword(String newPassword) async {
    User user = _firebaseAuthWeb.currentUser;
    String status;
    try {
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        status = e.code;
        print(e.code);
      }
    }
    return status;
  }

  Future<String> signToGoogle() async {
    String result;
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

      await _firebaseAuthWeb.signInWithCredential(credential);
      print('checking user data...');
      User user = FirebaseAuth.instance.currentUser;
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('customer')
            .doc(user.uid)
            .get();
        if (snapshot == null || !snapshot.exists) {
          String tarikh = '';
          var now = DateTime.now();
          var formatter = new DateFormat('dd-M-yyyy');
          tarikh = formatter.format(now);
          print('creating new database');
          await FirebaseFirestore.instance
              .collection('customer')
              .doc(user.uid)
              .set({
            'Tarikh': tarikh,
            'Nama': '${user.displayName}',
            'No Phone': '',
            'Email': '${user.email}',
            'Points': 10,
            'UID': user.uid,
            'photoURL': user.photoURL,
            'timeStamp': FieldValue.serverTimestamp(),
          });
          print('User has been succesfully created on database!');
          await _firebaseAuthWeb.signInWithCredential(credential);
          result = 'newuser';
        } else {
          result = 'login';
          print('user data exist');

          // await createUserData('', user.user.photoURL);
        }
      } catch (e) {
        print(e);
      }

      await Future.delayed(Duration(seconds: 3));
      print(result);
      return result;
    } on PlatformException catch (e) {
      if (e.code == 'popup_closed_by_user') {
        result = e.code;
        return result;
      }
      print(e.code);
      result = e.code;
      return result;
    }
  }

  Future<void> createUserData(String phone, String photo) async {
    User _user = _firebaseAuthWeb.currentUser;
    String tarikh = '';
    var now = DateTime.now();
    var formatter = new DateFormat('dd-M-yyyy');
    tarikh = formatter.format(now);
    Map<String, dynamic> createUser = {
      'Tarikh': tarikh,
      'Nama': '${_user.displayName}',
      'No Phone': '$phone',
      'Email': '${_user.email}',
      'Points': 10,
      'UID': _user.uid,
      'photoURL': photo,
      'timeStamp': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(_user.uid)
        .set(createUser)
        .then(
            (value) => print('User has been succesfully created on database!'));
  }
}
