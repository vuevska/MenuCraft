import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_category_model.dart';

class CategoryCard extends StatelessWidget {
  final RestaurantCategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Filter by category
        },
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(category.iconImage)),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
