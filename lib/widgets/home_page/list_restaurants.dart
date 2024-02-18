import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:provider/provider.dart';
import '../../models/restaurant_model.dart';
import '../../utils/location_services.dart';
import 'restaurant_card.dart';

class ListRestaurants extends StatefulWidget {
  const ListRestaurants({super.key});

  @override
  State<ListRestaurants> createState() => _ListRestaurntsState();
}

class _ListRestaurntsState extends State<ListRestaurants> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10.0),
        Consumer<LocationService>(
          builder: (_, location, child) => FutureBuilder<List<RestaurantModel>>(
            future: LocationService.checkPermission()
                ? DbRestaurantService()
                    .getLocalRestaurants(LocationService.getLastKnownPosition())
                : DbRestaurantService().getAllRestaurants(),
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
                final restaurants = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10.0),
                    for (int i = 0; i < restaurants.length; i++)
                      FadeInRightBig(
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 500 + i * 200),
                        child: RestaurantCard(restaurant: restaurants[i]),
                      ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
