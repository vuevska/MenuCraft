import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';
import '../../models/restaurant_model.dart';
import '../../services/db_service.dart';
import '../../utils/location_services.dart';
import 'expandable_card.dart';

// class ListRestaurants extends StatefulWidget {
//   const ListRestaurants({super.key});
//
//   @override
//   State<ListRestaurants> createState() => _ListRestaurntsState();
// }
//
// class _ListRestaurntsState extends State<ListRestaurants> {
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       color: Colors.purple,
//       onRefresh: () async {
//         setState(() {});
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 10.0),
//           Consumer<LocationService>(
//             builder: (_, location, child) => Expanded(
//               child: FutureBuilder<List<RestaurantModel>>(
//                 future: LocationService.checkPermission()
//                     ? DbAuthService().getLocalRestaurants(
//                         LocationService.getLastKnownPosition())
//                     : DbAuthService().getAllRestaurants(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text('Error: ${snapshot.error}'),
//                     );
//                   } else {
//                     final restaurants = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: restaurants.length,
//                       itemBuilder: (context, index) {
//                         final restaurant = restaurants[index];
//                         return ExpandableCard(
//                           restaurant: restaurant,
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ListRestaurants extends StatefulWidget {
  final CategoryModel? selectedCategory;

  const ListRestaurants({Key? key, this.selectedCategory}) : super(key: key);

  @override
  State<ListRestaurants> createState() => _ListRestaurantsState();
}

class _ListRestaurantsState extends State<ListRestaurants> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.purple,
      onRefresh: () async {
        setState(() {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10.0),
          Consumer<LocationService>(
            builder: (_, location, child) => Expanded(
              child: FutureBuilder<List<RestaurantModel>>(
                future: LocationService.checkPermission()
                    ? DbAuthService().getLocalRestaurants(
                    LocationService.getLastKnownPosition())
                    : DbAuthService().getAllRestaurants(),
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
                    final filteredRestaurants = widget.selectedCategory != null
                        ? restaurants
                        .where((restaurant) =>
                    restaurant.category ==
                        widget.selectedCategory!.name)
                        .toList()
                        : restaurants;
                    return ListView.builder(
                      itemCount: filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = filteredRestaurants[index];
                        return ExpandableCard(
                          restaurant: restaurant,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}