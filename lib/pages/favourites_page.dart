import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/favorites/favorite_restaurant_card.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key});

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
      body: Padding(
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
    );
  }
}

// TODO: ova da se odnese vo papka models
class Restaurant {
  final String name;
  final String location;
  final String imagePath;

  Restaurant({
    required this.name,
    required this.location,
    required this.imagePath,
  });
}
