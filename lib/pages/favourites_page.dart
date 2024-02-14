import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/favorite_provider.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../widgets/favorites/favorites_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                // Access the user's favorite restaurants from the user provider

                return Consumer<FavoriteProvider>(
                    builder: (context, favoriteProvider, child) {
                  return FutureBuilder(
                      future: context
                          .read<FavoriteProvider>()
                          .getFavorites(AuthService.user?.uid ?? 'local'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('An error occurred',
                                style: TextStyle(color: Colors.white)),
                          );
                        }
                        final favoriteRestaurants =
                            snapshot.data as List<RestaurantModel>;
                        if (favoriteRestaurants.isEmpty) {
                          return const Center(
                            child: Text('No favorite restaurants'),
                          );
                        }
                        return FavoriteList(
                            favoriteRestaurants: favoriteRestaurants);
                      });
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
