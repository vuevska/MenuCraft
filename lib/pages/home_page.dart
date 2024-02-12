import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/home_page/menu_list.dart';

import '../widgets/home_page/restaurant_category_card.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       backgroundColor: Theme.of(context).primaryColor,
//       body: const ListRestaurants(),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Cards
            SizedBox(
              height: 200, // Define the height for the category cards
              child: CategoryGrid(),
            ),
            Expanded(
              child: ListRestaurants(),
            ),
          ],
        ),
      ),
    );
  }
}