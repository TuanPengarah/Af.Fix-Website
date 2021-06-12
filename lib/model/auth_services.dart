import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AuthenticationServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuthWeb;
  String status = 'Sign in completed!';
  bool isError = false;
  AuthenticationServices(this._firebaseAuthWeb);

  // Stream<User> get authStateChanges {

  //   return _firebaseAuthWeb.authStateChanges();
  // }

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
}
