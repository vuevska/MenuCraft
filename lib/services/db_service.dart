import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';

class DbAuthService {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final _geo = GeoFlutterFire();

  Future<void> addUserEmail(String uid,
      String email,
      String name,
      String surname,) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'name': name,
      'surname': surname,
      'uid': uid,
    });
  }

  Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).get().then((doc) async {
      final imageLink = doc.data()?['imageUrl'] ?? "no link";
      if (imageLink != "no link") {
        await _storage.refFromURL(imageLink).delete();
      }
    });

    await _db.collection('users').doc(uid).delete();
  }

  Future<void> addNetworkImageToUser(String uid,
      String imageUrl,) async {
    await _db.collection('users').doc(uid).update({
      'imageUrl': imageUrl,
    });
  }

  Future<String> addLocalImageToUser(String uid,
      File file,) async {
    final firebaseStorageRef = _storage.ref().child('$uid/$uid.png');

    final uploadTask = firebaseStorageRef.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);

    final fileURL = await taskSnapshot.ref.getDownloadURL();

    await _db.collection('users').doc(uid).update({'imageUrl': fileURL});

    return fileURL;
  }

  Future<void> addGoogleAccount(String uid,
      String email,
      String name,) async {
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
    String hash =
    _geo
        .point(latitude: latitude, longitude: longitude)
        .data['geohash'];
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

  //TODO: razgledaj go ova
  // Future<void> addRestaurantToUser(String uid, String restaurantId) async {
  //   final userDocRef = _db.collection('users').doc(uid);
  //
  //   await userDocRef.update({
  //     'ownRestaurants': FieldValue.arrayUnion([restaurantId])
  //   });
  // }

  Future<List<RestaurantModel>> getLocalRestaurants(
      Future<Position?> lastLocation) async {
    Position? lastKnownPosition = await lastLocation;

    if (lastKnownPosition == null) {
      // Handle the case when lastKnownPosition is null
      return Future.error('Last known position is null');
    }

    GeoFirePoint center = _geo.point(
        latitude: lastKnownPosition.latitude,
        longitude: lastKnownPosition.longitude);

    var collectionReference = _db.collection('restaurants');

    double radius = 1;
    String field = 'geoPoint';
    List<DocumentSnapshot> documentList = await _geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field, strictMode: false)
        .first;

    List<RestaurantModel> restaurants = documentList
        .map((doc) =>
        RestaurantModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return restaurants;
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

  Future<List<RestaurantModel>> getAllRestaurauntsFromList(
      List<String> ids) async {
    return await Future.wait(ids.map((id) => getRestaurant(id)));
  }

  Future<RestaurantModel> getRestaurant(String id) {
    return _db.collection('restaurants').doc(id).get().then((doc) {
      return RestaurantModel.fromMap(doc.data() as Map<String, dynamic>);
    });
  }

  Future<String> uploadRestaurantImage(String restaurantId, File file) async {
    final firebaseStorageRef =
    _storage.ref().child('restaurants/$restaurantId.png');

    final uploadTask = firebaseStorageRef.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);

    final imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  Future<void> toggleFavorite(String restaurantId, String userId,
      bool favorite) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(restaurantId)
        .set({
      'id': restaurantId,
      'userId': userId,
      'favorite': favorite,
    });
  }

  Future<bool> isFavorite(String restaurantId, String userId) async {
    final favorites = await _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(restaurantId)
        .get();

    if (favorites.data() == null) return false;
    return favorites['favorite'];
  }

  Future<List<RestaurantModel>> getFavorites(String userId) async {
    final favorites =
    await _db.collection('users').doc(userId).collection("favorites").get();
    List<String> restIDs = [];

    print(favorites.docs.map((e) => e.data()));

    favorites.docs.forEach(
            (e) =>
        {
          if (e.data()['favorite'] == true) restIDs.add(e.data()['id'])
        });
    // favorites?.forEach((key, value) {
    //   if (value['favorite'] == true) {
    //     restIDs.add(value['id']);
    //   }
    // });
    return await getAllRestaurauntsFromList(restIDs);
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


// Function to retrieve category data from Firestore
  Future<CategoryModel?> getCategory(String categoryId) async {
    try {
      DocumentSnapshot categories =
      await _db.collection('restaurant_categories').doc(categoryId).get();
      if (categories.exists) {
        return CategoryModel.fromMap(categories.data()! as Map<String, dynamic>);
      } else {
        print('Category does not exist');
        return null;
      }
    } catch (error) {
      print('Error getting category: $error');
      return null;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      QuerySnapshot categorySnapshot =
      await _db.collection('restaurant_categories').get();

      List<CategoryModel> categories = categorySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return categories;
    } catch (error) {
      print('Error getting categories: $error');
      return [];
    }
  }

}


