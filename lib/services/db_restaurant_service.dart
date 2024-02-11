import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:menu_craft/models/category_model.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class DbRestaurantService {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final _geo = GeoFlutterFire();

  Future<void> addRestaurant({
    required String name,
    required double latitude,
    required double longitude,
    required String imageUrl,
    required String restaurantId,
    required String owningUserID,
    required List<CategoryModel> categories,
  }) async {
    String hash =
        _geo.point(latitude: latitude, longitude: longitude).data['geohash'];

    final restaurant = RestaurantModel(
      restaurantId: restaurantId,
      name: name,
      geoHash: hash,
      latitude: latitude,
      longitude: longitude,
      imageUrl: imageUrl,
      owningUserID: owningUserID,
    );

    final Map<String, dynamic> restaurantData = restaurant.toMap();

    await _db.collection('restaurants').doc(restaurantId).set(restaurantData);

    // Ova gi zacuvuva categoriite vo subcollection
    final categoryCollectionRef = _db
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories');
    for (var category in categories) {
      await categoryCollectionRef
          .doc(category.categoryId)
          .set(category.toMap());
    }
  }

  Future<List<RestaurantModel>> getLocalRestaurants(
      Future<Position?> lastLocation) async {
    Position? lastKnownPosition = await lastLocation;

    if (lastKnownPosition == null) {
      // Handle the case when lastKnownPosition is null
      return Future.error('Last known position is null');
    }

    GeoFirePoint center = _geo.point(
      latitude: lastKnownPosition.latitude,
      longitude: lastKnownPosition.longitude,
    );

    var collectionReference = _db.collection('restaurants');

    double radius = 1;
    String field = 'geoPoint';
    List<DocumentSnapshot> documentList = await _geo
        .collection(collectionRef: collectionReference)
        .within(
          center: center,
          radius: radius,
          field: field,
          strictMode: false,
        )
        .first;

    List<RestaurantModel> restaurants = [];
    for (var doc in documentList) {
      final dynamic data = doc.data();
      restaurants.add(RestaurantModel.fromMap(data as Map<String, dynamic>));
    }
    return restaurants;
  }

  Future<List<RestaurantModel>> getAllRestaurants() async {
    QuerySnapshot restaurantSnapshot =
        await _db.collection('restaurants').get();

    List<RestaurantModel> restaurants = [];
    for (var doc in restaurantSnapshot.docs) {
      final dynamic data = doc.data();
      restaurants.add(RestaurantModel.fromMap(data as Map<String, dynamic>));
    }
    return restaurants;
  }

  Future<List<RestaurantModel>> getAllRestaurauntsFromList(
      List<String> ids) async {
    return await Future.wait(ids.map((id) => getRestaurant(id)));
  }

  Future<RestaurantModel> getRestaurant(String id) async {
    DocumentSnapshot restaurantDoc =
        await _db.collection('restaurants').doc(id).get();

    final dynamic data = restaurantDoc.data();
    return RestaurantModel.fromMap(data as Map<String, dynamic>);
  }

  Future<List<RestaurantModel>> getRestaurantsByUserId(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _db
          .collection('restaurants')
          .where('owningUserID', isEqualTo: userId)
          .get();

      List<RestaurantModel> restaurants = [];
      for (var doc in querySnapshot.docs) {
        final restaurantData = doc.data() as Map<String, dynamic>;
        restaurants.add(RestaurantModel.fromMap(restaurantData));
      }

      return restaurants;
    } catch (e) {
      print('Error getting restaurants by user ID: $e');
      rethrow;
    }
  }

  Future<void> addCategoryToRestaurant(
      String restaurantId, Map<String, dynamic> category) async {
    try {
      final restaurantRef = _db.collection('restaurants').doc(restaurantId);

      // dokolku nema categories subcollection, ja kreira pa posle dodava
      final categoriesSnapshot =
          await restaurantRef.collection('categories').get();
      if (categoriesSnapshot.docs.isEmpty) {
        await restaurantRef.collection('categories').doc().set({});
      }

      await restaurantRef.collection('categories').add(category);
    } catch (e) {
      print('Error adding category to restaurant: $e');
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategoriesForRestaurant(
      String restaurantId) async {
    try {
      QuerySnapshot categorySnapshot = await _db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .get();

      List<CategoryModel> categories = categorySnapshot.docs.map((doc) {
        return CategoryModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return categories;
    } catch (error) {
      print('Error getting categories for restaurant: $error');
      return [];
    }
  }

  Future<String> uploadRestaurantImage(String restaurantId, File file) async {
    final firebaseStorageRef =
        _storage.ref().child('restaurants/$restaurantId.png');

    final uploadTask = firebaseStorageRef.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);

    final imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  Future<void> toggleFavorite(
      String restaurantId, String userId, bool favorite) async {
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
        (e) => {if (e.data()['favorite'] == true) restIDs.add(e.data()['id'])});
    // favorites?.forEach((key, value) {
    //   if (value['favorite'] == true) {
    //     restIDs.add(value['id']);
    //   }
    // });
    return await getAllRestaurauntsFromList(restIDs);
  }
}
