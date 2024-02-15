import 'package:flutter/material.dart';

import '../../models/restaurant_category_model.dart';
import '../../models/restaurant_model.dart';
import '../../services/db_restaurant_service.dart';
import '../../widgets/home_page/restaurant_card.dart';


class RestaurantListPage extends StatelessWidget {
  final RestaurantCategoryModel category;

  const RestaurantListPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 27, 32, 1), // Adjust the color here
      appBar: AppBar(
        title: Text('${category.name}'),
        backgroundColor: const Color.fromRGBO(29, 27, 32, 1),
        foregroundColor: Colors.white,// Adjust the color here
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white)// Remove the elevation of the app bar
      ),
      body: FutureBuilder<List<RestaurantModel>>(
        future: DbRestaurantService().getRestaurantsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)),
            );
          } else {
            final List<RestaurantModel> restaurants = snapshot.data!;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return RestaurantCard(restaurant: restaurant);
              },
            );
          }
        },
      ),
    );
  }
}
