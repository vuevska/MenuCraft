import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class DbAuthService {
  final _db = FirebaseFirestore.instance;

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

  Future<UserModel> getUser(String uid) async {
    DocumentSnapshot user = await _db.collection('users').doc(uid).get();

    return UserModel.fromMap(user.data() as Map<String, dynamic>);
  }
}
