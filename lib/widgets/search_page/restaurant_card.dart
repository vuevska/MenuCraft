import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';

import '../../pages/restaurant/view_menu_page.dart';

class RestaurantNameCard extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantNameCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        restaurant.name,
        style: const TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white),
      ),
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return ViewMenuPage(restaurant: restaurant);
            },
          ),
        );
      },
    );
  }
}
