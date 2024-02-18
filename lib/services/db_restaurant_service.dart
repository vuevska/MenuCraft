import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:menu_craft/models/items_category_model.dart';
import 'package:menu_craft/models/menu_item_model.dart';
import 'package:menu_craft/models/restaurant_category_model.dart';
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
    required String category,
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
        category: category);

    final Map<String, dynamic> restaurantData = restaurant.toMap();

    await _db.collection('restaurants').doc(restaurantId).set(restaurantData);
  }

  Future<List<RestaurantModel>> getLocalRestaurants(
      Future<Position?> lastLocation) async {
    Position? lastKnownPosition = await lastLocation;

    if (lastKnownPosition == null) {
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
    return await Future.wait(ids.map((id) async {
      try {
        return await getRestaurant(id);
      } catch (e) {
        debugPrint('Error fetching restaurant with ID $id: $e');
        return null;
      }
    })).then((value) {
      return value.where((element) => element != null).map((e) => e!).toList();
    });
  }

  Future<RestaurantModel> getRestaurant(String id) async {
    DocumentSnapshot restaurantDoc =
        await _db.collection('restaurants').doc(id).get();

    final dynamic data = restaurantDoc.data();
    return RestaurantModel.fromMap(data as Map<String, dynamic>);
  }

  Future<RestaurantModel?> checkAndGetRestauraunt(String id) {
    return _db.collection('restaurants').doc(id).get().then((doc) {
      return RestaurantModel.fromMap(doc.data() as Map<String, dynamic>);
    });
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
      debugPrint('Error getting restaurants by user ID: $e');
      rethrow;
    }
  }

  Future<void> addItemsCategoryToRestaurant(
      String restaurantId, Map<String, dynamic> category) async {
    try {
      final restaurantRef = _db.collection('restaurants').doc(restaurantId);

      await restaurantRef
          .collection('categories')
          .doc(category["categoryId"])
          .set(category);
    } catch (e) {
      debugPrint('Error adding category to restaurant: $e');
      rethrow;
    }
  }

  Future<List<ItemsCategoryModel>> getItemsCategoriesForRestaurant(
      String restaurantId) async {
    try {
      QuerySnapshot categorySnapshot = await _db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .get();

      // proverka dali categoryId e prazno
      List<ItemsCategoryModel> categories = [];
      for (var doc in categorySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final categoryId = data['categoryId'] as String?;
        if (categoryId != null && categoryId.isNotEmpty) {
          final category = ItemsCategoryModel.fromMap(data);
          categories.add(category);
        }
      }

      return categories;
    } catch (error) {
      debugPrint('Error getting categories for restaurant: $error');
      return [];
    }
  }

  Future<void> updateItemsCategory({
    required String restaurantId,
    required String categoryId,
    required ItemsCategoryModel updatedCategory,
  }) async {
    try {
      final categoryRef = _db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId);

      await categoryRef.update(updatedCategory.toMap());
    } catch (e) {
      debugPrint('Error updating items category: $e');
      rethrow;
    }
  }

  Future<void> updateMenuItem(String restaurantId, String categoryId,
      MenuItemModel updatedMenuItem) async {
    try {
      await _db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .collection('menuItems')
          .doc(updatedMenuItem.menuItemId)
          .update(updatedMenuItem.toMap());
    } catch (e) {
      throw Exception('Failed to update menu item: $e');
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

    return await getAllRestaurauntsFromList(restIDs);
  }

  Future<void> addMenuItem({
    required String name,
    required double price,
    required String description,
    required String menuItemId,
    required String owningUserID,
    required String categoryId,
  }) async {
    try {
      final menuItem = MenuItemModel(
        menuItemId: menuItemId,
        name: name,
        price: price,
        description: description,
      );

      final Map<String, dynamic> menuItemData = menuItem.toMap();

      await _db
          .collection('restaurants')
          .doc(categoryId)
          .collection('menu_items')
          .doc(menuItemId)
          .set(menuItemData);
    } catch (e) {
      debugPrint('Error adding menu item: $e');
      rethrow;
    }
  }

  Future<void> addMenuItemToCategory(
      String restaurantId, String categoryId, MenuItemModel menuItem) async {
    try {
      final categoryRef = _db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId);

      final menuItemsCollectionRef = categoryRef.collection('menuItems');

      await menuItemsCollectionRef
          .doc(menuItem.menuItemId)
          .set(menuItem.toMap());
    } catch (e) {
      debugPrint('Error adding menu item to category: $e');
      rethrow;
    }
  }

  Future<List<MenuItemModel>> getMenuItemsInCategory(
      String restaurantId, String categoryId) async {
    try {
      final categoryRef = _db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId);
      final menuItemsSnapshot = await categoryRef.collection('menuItems').get();

      List<MenuItemModel> menuItems = [];
      for (var doc in menuItemsSnapshot.docs) {
        final menuItemData = doc.data();
        final menuItem = MenuItemModel.fromMap(menuItemData);
        if (menuItem.menuItemId.isNotEmpty) {
          menuItems.add(menuItem);
        }
      }

      return menuItems;
    } catch (e) {
      debugPrint('Error getting menu items in category: $e');
      return [];
    }
  }

  Future<List<RestaurantCategoryModel>> getAllCategories() async {
    try {
      QuerySnapshot categorySnapshot =
          await _db.collection('restaurant_categories').get();

      List<RestaurantCategoryModel> categories = categorySnapshot.docs
          .map((doc) => RestaurantCategoryModel.fromMap(
              doc.data() as Map<String, dynamic>))
          .toList();
      return categories;
    } catch (error) {
      debugPrint('Error getting categories: $error');
      return [];
    }
  }

  Future<void> deleteRestaurant(String restaurantId) async {
    try {
      await _db.collection('restaurants').doc(restaurantId).delete();
    } catch (e) {
      debugPrint('Error deleting restaurant: $e');
      rethrow;
    }
  }

  Future<void> updateRestaurant({
    required String name,
    required double latitude,
    required double longitude,
    required String imageUrl,
    required String restaurantId,
    required String owningUserID,
    required String category,
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
        category: category);

    final Map<String, dynamic> restaurantData = restaurant.toMap();

    await _db
        .collection('restaurants')
        .doc(restaurantId)
        .update(restaurantData);
  }

  Future<List<RestaurantModel>> getRestaurantsByCategory(
      RestaurantCategoryModel category) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('restaurants').get();
    final List<RestaurantModel> restaurants = [];
    for (var doc in snapshot.docs) {
      final data = doc.data();
      if (data['category'] == category.name) {
        final restaurant = RestaurantModel.fromMap(data);
        restaurants.add(restaurant);
      }
    }
    return restaurants;
  }

  Future<void> deleteCategory(String restaurantId, String categoryId) async {
    try {
      await _db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .delete();
    } catch (e) {
      debugPrint('Error deleting category: $e');
    }
  }

  Future<void> deleteMenuItem(
      String restaurantId, String categoryId, String menuItemId) async {
    try {
      await _db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .collection('menuItems')
          .doc(menuItemId)
          .delete();
    } catch (e) {
      debugPrint('Error deleting menuItem: $e');
    }
  }
}
