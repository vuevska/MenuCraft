import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_craft/models/restaurant.dart';

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

  Future<List<Restaurant>> getAllRestaurants() async {
    QuerySnapshot restaurantSnapshot =
        await _db.collection('restaurants').get();

    List<Restaurant> restaurants = restaurantSnapshot.docs
        .map((doc) => Restaurant.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return restaurants;
  }

  Future<void> addRestaurantToFavorites(
      String userId, String restaurantId) async {
    await _db.collection('users').doc(userId).update({
      'favoriteRestaurants': FieldValue.arrayUnion([restaurantId]),
    });
  }

  Future<void> removeRestaurantFromFavorites(
      String userId, String restaurantId) async {
    await _db.collection('users').doc(userId).update({
      'favoriteRestaurants': FieldValue.arrayRemove([restaurantId]),
    });
  }
}
