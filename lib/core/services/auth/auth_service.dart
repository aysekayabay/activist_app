// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();
  static late final AuthService instance = AuthService._();
  String? uid;
  dynamic userData;

  Future<int> register(BuildContext context, String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (user.user != null) {
        uid = user.user!.uid;
        return 1;
      } else {
        return 0;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      return -1;
    }
  }

  Future<int> login(BuildContext context, String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        uid = user.user!.uid;
        return 1;
      } else {
        return 0;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      return -1;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    uid = null;
    userData = null;
  }

  Future<int> signInWithTwitter() async {
    TwitterAuthProvider twitterProvider = TwitterAuthProvider();
    if (kIsWeb) {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(twitterProvider);
      if (userCredential != null) {
        uid = userCredential.user!.uid;
        return 1;
      }
      return 0;
    } else {
      await FirebaseAuth.instance.signInWithProvider(twitterProvider);
      return 0;
    }
  }

  // Future<int> signInWithFacebook() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   if (loginResult != null) {
  //     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //     if (userCredential != null) {
  //       return 1;
  //     }
  //   }
  //   return 0;
  // }

  Future<int> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential != null) {
        uid = userCredential.user!.uid;
        return 1;
      }
    } on GoogleAuthCredential catch (e) {
      print(e);
    }
    return 0;
  }
}
