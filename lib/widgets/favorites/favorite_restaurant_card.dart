import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant.dart';

class FavoriteRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteRestaurantCard({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(restaurant.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(restaurant.location),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Remove"),
                    Icon(Icons.star),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
