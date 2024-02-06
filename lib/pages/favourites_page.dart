import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/favorites/favorite_restaurant_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // TODO: treba da se zemat omilenite menija od najaveniot korisnik
    List<Restaurant> favoriteRestaurants = [
      Restaurant(
        name: 'Woodstock Beer Bar',
        location: 'ul. Franklin Ruzvelt',
        imagePath: 'images/woodstock.jpg',
      ),
      Restaurant(
        name: 'Beer Garden',
        location: 'ul. Boemska',
        imagePath: 'images/woodstock.jpg',
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 22.0),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: favoriteRestaurants.length,
            itemBuilder: (BuildContext context, int index) {
              return FavoriteRestaurantCard(
                restaurant: favoriteRestaurants[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
