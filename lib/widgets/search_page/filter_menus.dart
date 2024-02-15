import 'package:flutter/material.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/widgets/search_page/restaurant_card.dart';

import '../../models/restaurant_model.dart';

class FilterRestaurants extends StatefulWidget {
  final String searchQuery;

  const FilterRestaurants({super.key, required this.searchQuery});

  @override
  State<FilterRestaurants> createState() => _FilterRestaurantsState();
}

class _FilterRestaurantsState extends State<FilterRestaurants> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RestaurantModel>>(
      future:
          DbRestaurantService().getAllRestaurants(), // Fetch all restaurants
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<RestaurantModel> allRestaurants = snapshot.data!;
          List<RestaurantModel> filteredRestaurants = [];

          if (widget.searchQuery.isEmpty) {
            // Show nearby restaurants if search query is empty
            filteredRestaurants = allRestaurants.toList();
          } else {
            // Search from all restaurants if there's a search query
            filteredRestaurants = allRestaurants
                .where((restaurant) => restaurant.name
                    .toLowerCase()
                    .contains(widget.searchQuery.toLowerCase()))
                .toList();
          }

          return ListView.builder(
            itemCount: filteredRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = filteredRestaurants[index];
              return RestaurantNameCard(restaurant: restaurant);
            },
          );
        }
      },
    );
  }
}
