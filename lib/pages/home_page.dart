import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/pages/restaurant/filtered_restaurants.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/home_page/list_restaurants.dart';

import '../models/restaurant_category_model.dart';
import '../widgets/home_page/restaurant_categories/restaurant_category_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RestaurantCategoryModel? selectedCategory;

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
            children: [
              SizedBox(
                height: 200,
                child: CategoryGrid(
                  onCategorySelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                    if (selectedCategory != null) {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) {
                            return RestaurantListPage(
                                category: selectedCategory!);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              ListRestaurants(), // NE KLAVAJ CONST NEMA DA RABOTI
            ],
          ),
        ),
      ),
    );
  }
}
