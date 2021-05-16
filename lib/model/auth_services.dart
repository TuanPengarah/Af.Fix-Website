import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuthWeb;

  AuthenticationServices(this._firebaseAuthWeb);

  Stream<User> get authStateChanges => _firebaseAuthWeb.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuthWeb.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed in';
    } on FirebaseException catch (e) {
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
