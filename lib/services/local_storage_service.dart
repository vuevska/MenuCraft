import 'package:localstore/localstore.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/services/db_service.dart';

class LocalStorageService {
  static final localDB = Localstore.instance;
  static final _firebaseDb = DbAuthService();

  static Future<void> toggleFavorite(
      String restaurantId, String userId, bool favorite) async {
    await localDB
        .collection('favorites')
        .doc(userId)
        .collection('restaurant')
        .doc(restaurantId)
        .set({
      'id': restaurantId,
      'userId': userId,
      'favorite': favorite,
    });

  }

  static Future<bool> isFavorite(String restaurantId, String userId) async {
    final favorites = await localDB
        .collection('favorites')
        .doc(userId)
        .collection('restaurant')
        .doc(restaurantId)
        .get();
    if (favorites == null) return false;
    return favorites['favorite'];
  }

  static Future<List<RestaurantModel>> getFavorites(String userId) async {
    final favorites = await localDB
        .collection('favorites')
        .doc(userId)
        .collection("restaurant")
        .get();
    List<String> restIDs = [];

    favorites?.forEach((key, value) {
      if (value['favorite'] == true) {
        restIDs.add(value['id']);
      }
    });
    return await _firebaseDb.getAllRestaurauntsFromList(restIDs);
  }
}
