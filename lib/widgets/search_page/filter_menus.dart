import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/search_page/restaurant_card.dart';

import '../../models/restaurant_model.dart';
import '../../services/db_service.dart';
import '../../utils/location_services.dart';
import '../home_page/expandable_card.dart';


class FilterRestaurants extends StatefulWidget {
  const FilterRestaurants({Key? key});

  @override
  State<FilterRestaurants> createState() => _FilterRestaurantsState();
}

class _FilterRestaurantsState extends State<FilterRestaurants> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RestaurantModel>>(
      future: LocationService.checkPermission()
          ? DbAuthService().getLocalRestoraunts(
          LocationService.getLastKnownPosition())
          : DbAuthService().getAllRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final restaurants = snapshot.data!;
          return ListView.builder(
            itemCount: restaurants.length > 5 ? 5 : restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantNameCard(name: restaurant.name);
            },
          );
        }
      },
    );
  }
}


