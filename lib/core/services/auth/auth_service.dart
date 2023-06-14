// ignore_for_file: unnecessary_null_comparison

import 'package:akademi_bootcamp/core/services/firestore/firestore_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        userData = await FirestoreManager.instance.firestoreGetDocument(collectionID: "user", documentID: user.user!.uid);
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
}
