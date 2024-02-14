import 'package:flutter/material.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../../models/providers/favorite_provider.dart';
import '../../models/restaurant_model.dart';
import '../../services/auth_service.dart';
import 'favorite_restaurant_card.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key, required this.favoriteRestaurants});
  final List<RestaurantModel> favoriteRestaurants;
  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: widget.favoriteRestaurants.length,
      itemBuilder: (BuildContext context, int index) {
        return FavoriteRestaurantCard(
          restaurant: widget.favoriteRestaurants[index],
          index: index,
          onDelete: (i) {
            setState(() {
              print(widget.favoriteRestaurants.length);
              print(widget.favoriteRestaurants[i].name);
              context.read<FavoriteProvider>().toggleFavorite(
                  widget.favoriteRestaurants[i].restaurantId,
                  AuthService.user?.uid ?? 'local',
                  true);
              widget.favoriteRestaurants.removeAt(i);
              InterfaceUtils.show(context, "Menu removed from favorites!",
                  type: ToastificationType.info);
            });
          },
        );
      },
    );
  }
}
