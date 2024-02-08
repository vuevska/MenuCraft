import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

import '../models/user_model.dart';

class DbAuthService {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final _geo = GeoFlutterFire();

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

  Future<void> addRestaurant({
    required String name,
    required double latitude,
    required double longitude,
    required String imageUrl,
    required String restaurantId,
    required String owningUserID,
  }) async {
    String hash = _geo.point(latitude: latitude, longitude: longitude).data['geohash'];
    final restaurant = RestaurantModel(
      name: name,
      geoHash: hash,
      latitude: latitude,
      longitude: longitude,
      imageUrl: imageUrl,
      restaurantId: restaurantId,
      owningUserID: owningUserID,
    );


    await _db
        .collection('restaurants')
        .doc(restaurantId)
        .set(restaurant.toMap());
  }

  Future<void> addRestaurantToUser(String uid, String restaurantId) async {
    final userDocRef = _db.collection('users').doc(uid);

    await userDocRef.update({
      'ownRestaurants': FieldValue.arrayUnion([restaurantId])
    });
  }

  Future<List<RestaurantModel>> getAllRestaurants() async {
    QuerySnapshot restaurantSnapshot =
        await _db.collection('restaurants').get();



    List<RestaurantModel> restaurants = restaurantSnapshot.docs
        .map((doc) =>
            RestaurantModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return restaurants;
  }

  Future<String> uploadRestaurantImage(String restaurantId, File file) async {
    final firebaseStorageRef =
        _storage.ref().child('restaurants/$restaurantId.png');

    final uploadTask = firebaseStorageRef.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);

    final imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

// Future<void> addRestaurantToFavorites(
//     String userId, String restaurantId) async {
//   await _db.collection('users').doc(userId).update({
//     'favoriteRestaurants': FieldValue.arrayUnion([restaurantId]),
//   });
// }

// Future<void> removeRestaurantFromFavorites(
//     String userId, String restaurantId) async {
//   await _db.collection('users').doc(userId).update({
//     'favoriteRestaurants': FieldValue.arrayRemove([restaurantId]),
//   });
// }
}
