import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? user;

  static bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }



  static Future signInWithMail(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      return user;
    } on FirebaseAuthException catch (e, _) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid Email or Password!"),
      ));
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  static Future signUpWithMail(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      user = result.user;
      user?.sendEmailVerification();

      return user;
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  //TODO: google sign in
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  static User? getCurrentUser() {
    return user;
  }

  static String? getEmailOfCurrentUser() {
    return user?.email;
  }
}
