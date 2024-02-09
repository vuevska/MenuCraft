import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/favorite_provider.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/favorites/favorite_restaurant_card.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key});

  // TODO: Change logic here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        color: Theme
            .of(context)
            .primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 22.0),
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              // Access the user's favorite restaurants from the user provider


              return Consumer<FavoriteProvider>(
                builder: (context, favorites, child) {
                      
                  
                  return FutureBuilder(
                    future: favorites.getFavorites(AuthService.user?.uid ?? 'local'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('An error occurred'),
                        );
                      }
                      final favoriteRestaurants = snapshot.data as List<RestaurantModel>;
                      if (favoriteRestaurants.isEmpty) {
                        return const Center(
                          child: Text('No favorite restaurants'),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: favoriteRestaurants.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FavoriteRestaurantCard(
                            restaurant: favoriteRestaurants[index],
                          );
                        },
                      );
                    }

                  );
                }
                ,
              );
            },
          ),
        ),
      ),
    );
  }
}
