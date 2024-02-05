import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? user;
  static UserCredential? userCredential;

  static bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future signInWithMail(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      user = result.user;
      userCredential = result;

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
      userCredential = result;
      user?.sendEmailVerification();

      return user;
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  static Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    user = userCredential?.user;

    // Once signed in, return the UserCredential
    return userCredential ;
  }


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
