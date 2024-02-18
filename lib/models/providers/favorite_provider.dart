import 'package:flutter/cupertino.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';

import '../../services/local_storage_service.dart';
import '../restaurant_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final DbRestaurantService _db = DbRestaurantService();

  Future<void> toggleFavorite(String id, String userId, bool isFavorite) async {
    if (userId == 'local') {
      await LocalStorageService.toggleFavorite(id, userId, !isFavorite);
    } else {
      await _db.toggleFavorite(id, userId, !isFavorite);
    }

    notifyListeners();
  }

  Future<bool> isFavorite(String id, String userId) async {
    if (userId == 'local') {
      return await LocalStorageService.isFavorite(id, userId);
    } else {
      return await _db.isFavorite(id, userId);
    }
  }

  Future<List<RestaurantModel>> getFavorites(String userId) async {
    if (userId == 'local') {
      return await LocalStorageService.getFavorites(userId);
    } else {
      return await _db.getFavorites(userId);
    }
  }
}
