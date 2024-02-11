import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/widgets/profile/restaurant_owner_card.dart';
import 'package:provider/provider.dart';

class ListOwnerRestaurants extends StatelessWidget {
  const ListOwnerRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) {
        return FutureBuilder<List<RestaurantModel>>(
          future:
              DbRestaurantService().getRestaurantsByUserId(user.user!.userId),
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
              final List<RestaurantModel> restaurants = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final RestaurantModel restaurant = restaurants[index];
                  return RestaurantOwnerCard(
                    restaurant: restaurant,
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
