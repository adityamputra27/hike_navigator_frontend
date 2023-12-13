import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth;
  FirebaseService(this._auth);
  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.idToken != null && googleAuth?.accessToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        print(userCredential.user);
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {}
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!)),
      );
    }
  }
}
