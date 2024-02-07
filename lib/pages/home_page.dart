import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/add_restaurant.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/services/db_service.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/home_page/expandable_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10.0),
          const SizedBox(height: 20.0),
          Expanded(
            child: FutureBuilder<List<RestaurantModel>>(
              future: DbAuthService().getAllRestaurants(),
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
                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return ExpandableCard(
                        restaurant: restaurant,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AuthService.isUserLoggedIn()
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) {
                      return const AddRestaurantPage();
                    },
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
              label: const Text(
                "Add Restaurant",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null, // If user is not logged in, don't show the button
    );
  }
}
