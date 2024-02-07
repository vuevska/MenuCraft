import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/models/user_model.dart';
import 'package:menu_craft/services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  void updateImage(String imageUrl) {
    _user?.imageUrl = imageUrl;
    notifyListeners();
  }

  List<RestaurantModel> get favoriteRestaurants {
    if (_user != null) {
      return _user!.ownRestaurants.map((restaurantId) {
        // TODO: get actual restaurants here
        print(restaurantId);
        return RestaurantModel(
          name: 'Restaurant $restaurantId',
          location: 'Location $restaurantId',
          imageUrl: 'images/restaurant.jpg',
          restaurantId: '',
        );
      }).toList();
    } else {
      return [];
    }
  }

  String? get fullName => "${_user?.name ?? ""} ${_user?.surname ?? ""}";

  String? get name => _user?.name;

  String? get surname => _user?.surname;

  String? get email => _user?.email;

  String? get imageUrl => _user?.imageUrl;

  String initial() {
    if (_user == null) return "";
    if (_user!.surname.isNotEmpty) {
      return "${_user?.name[0].toUpperCase() ?? ""}${_user?.surname[0].toUpperCase() ?? ""}";
    } else {
      return _user?.name.substring(0, 2).toUpperCase() ?? "";
    }
  }
}
