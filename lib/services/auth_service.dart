import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import 'db_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final DbAuthService _db = DbAuthService();
  static User? user;
  static UserCredential? userCredential;

  static bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<UserModel> signInWithMail(
    BuildContext context,
    String email,
    String password,
  ) async {
    UserCredential result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCredential = value;
      user = value.user;
      return value;
    });
    return await _db.getUser(result.user!.uid);
  }

  static Future signUpWithMail(
    BuildContext context,
    String email,
    String password,
    String name,
    String surname,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      user = result.user;
      userCredential = result;
      user?.sendEmailVerification();
      user?.updateDisplayName(name);

      _db.addUserEmail(user!.uid, email, name, surname);

      return user;
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()), // TODO: da go premestam vo glavnio del
      ));
    }
  }

  static Future<UserModel> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    user = userCredential?.user;

    _db.addGoogleAccount(
      userCredential?.user?.uid ?? "",
      //TODO: sigurno postoj podobar nacin za ova da se napraj
      userCredential?.additionalUserInfo?.profile?["email"],
      userCredential?.additionalUserInfo?.profile?["name"],
    );
    // Once signed in, return the UserCredential
    return await _db.getUser(user!.uid);
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    userCredential = null;
  }

  static User? getCurrentUser() {
    return user;
  }

  static String? getEmailOfCurrentUser() {
    return user?.email;
  }
}
