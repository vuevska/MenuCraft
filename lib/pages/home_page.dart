import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/home_page/list_restaurants.dart';

import '../widgets/home_page/restaurant_categories/restaurant_category_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: RefreshIndicator(
          color: Colors.purple,
          onRefresh: () async {
            setState(() {});
          },
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              // Category Cards
              SizedBox(
                height: 200, // Define the height for the category cards
                child: CategoryGrid(),
              ),
              ListRestaurants(),
            ],
          ),
        ),
      ),
    );
  }
}
