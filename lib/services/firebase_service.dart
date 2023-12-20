import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hike_navigator/cubit/page_cubit.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/ui/pages/main_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        showLoading(context);
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          final payload = {
            'email': userCredential.user!.email,
            'name': userCredential.user!.displayName,
            'register_type': 'FIREBASE',
          };
          final result =
              await API().postRequest(route: '/oauth', payload: payload);
          final response = jsonDecode(result.body);
          if (response['status'] == 200) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.setInt('user_id', response['user']['id']);
            await preferences.setString('name', response['user']['name']);
            await preferences.setString('email', response['user']['email']);
            await preferences.setString('role', response['user']['role']);
            await preferences.setString('token', response['token']);
            await preferences.setString(
                'auth_type', response['user']['register_type']);
            await preferences.setString(
                'version', response['setting']['version']);

            hideLoading(context);
            context.read<PageCubit>().setPage(0);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    preferences: preferences,
                  ),
                ),
                (Route route) => false);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      print("Google Sign-In Error: ${e.message}");
      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!)),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!)),
      );
    }
  }

  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          color: greyColor,
        ),
      ),
    );
  }

  void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }
}
