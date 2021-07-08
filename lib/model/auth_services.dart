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
      } else {
        isError = true;
        getError(e.message);
        return e.message;
      }
    }
  }

  Future<String> signUp(
      {String email, String password, String name, String phone}) async {
    try {
      await _firebaseAuthWeb
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) async {
        await credential.user.updateProfile(displayName: name);
        await createUserData(phone);
      });
      return 'Signed up';
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        isError = true;
        getError('Password is to weak');
        return e.message;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        isError = true;
        getError(e.message);
        return e.message;
      }

      isError = true;
      getError(e.message);
      print(e.code);
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
    try {
      return await _user.linkWithCredential(credential).then((newUser) async {
        await newUser.user.updateProfile(
            displayName: googleUser.displayName, photoURL: googleUser.photoUrl);
        try {
          await newUser.user.updateEmail(googleUser.email);
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
            getError(
                'For security reason, Please log out and log in again to prevent your account been hijacking');
          }
          isError = true;
          print(e.code);
          getError(e.message);
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
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
      print(e.code);
      getError(e.message);
      if (e.code == 'popup_closed_by_user') {
        getError('Sign in failed!');
      }
    }
  }

  Future<void> createUserData(String phone) async {
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
      'UID': _user.uid
    };
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(_user.uid)
        .set(createUser)
        .then(
            (value) => print('User has been succesfully created on database!'));
  }
}
