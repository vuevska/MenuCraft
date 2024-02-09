

import 'package:flutter/cupertino.dart';

import '../../services/local_storage_service.dart';
import '../restaurant_model.dart';

class FavoriteProvider extends ChangeNotifier {


  Future<void> toggleFavorite(String id, String userId, bool isFavorite) async {
    await LocalStorageService.toggleFavorite(id, userId, !isFavorite);

    notifyListeners();
  }

  Future<bool> isFavorite(String id, String userId) async {
    return await LocalStorageService.isFavorite(id, userId);
  }

  Future<List<RestaurantModel>> getFavorites(String userId) async {
    return await LocalStorageService.getFavorites(userId);
  }
}
