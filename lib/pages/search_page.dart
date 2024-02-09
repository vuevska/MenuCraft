import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/search_page/search_input.dart';
import '../../models/restaurant_model.dart'; // Import your RestaurantModel
import '../../services/db_service.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).primaryColor,
        child: const Column(
          children: [
            SearchBarCustom(),
          ],
        ),
      ),
    );
  }
}

// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key});
//
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   late Future<List<RestaurantModel>> _restaurantsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _restaurantsFuture = DbAuthService().getAllRestaurants(); // Fetch list of restaurants from database
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         color: Theme.of(context).primaryColor,
//         child: FutureBuilder<List<RestaurantModel>>(
//           future: _restaurantsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else {
//               List<RestaurantModel> restaurants = snapshot.data ?? [];
//               return Column(
//                 children: [
//                   SearchBarCustom(restaurants: restaurants), // Pass the list of restaurants to SearchBarCustom
//                   // Other widgets...
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
