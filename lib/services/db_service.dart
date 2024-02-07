import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/user_model.dart';

class DbAuthService {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> addUserEmail(
    String uid,
    String email,
    String name,
    String surname,
  ) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'name': name,
      'surname': surname,
      'uid': uid,
    });
  }

  Future<void> addNetworkImageToUser(
    String uid,
    String imageUrl,
  ) async {
    await _db.collection('users').doc(uid).update({
      'imageUrl': imageUrl,
    });
  }

  Future<String> addLocalImageToUser(
    String uid,
    File file,
  ) async {
    final firebaseStorageRef = _storage.ref().child('$uid/$uid.png');

    final uploadTask = firebaseStorageRef.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);

    final fileURL = await taskSnapshot.ref.getDownloadURL();

    await _db.collection('users').doc(uid).update({'imageUrl': fileURL});

    return fileURL;
  }

  Future<void> addGoogleAccount(
    String uid,
    String email,
    String name,
  ) async {
    await _db.collection("users").doc(uid).set({
      'email': email,
      'name': name,
      'uid': uid,
    });
  }

  Future<UserModel> getUser(String uid) async {
    DocumentSnapshot user = await _db.collection('users').doc(uid).get();

    return UserModel.fromMap(user.data() as Map<String, dynamic>);
  }
}
