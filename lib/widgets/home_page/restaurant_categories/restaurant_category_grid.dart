import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_category_model.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/widgets/home_page/restaurant_categories/restaurant_category_card.dart';



class CategoryGrid extends StatelessWidget {

  final Function(RestaurantCategoryModel?) onCategorySelected;

  const CategoryGrid({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<RestaurantCategoryModel>>(
      future: DbRestaurantService().getAllCategories(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)),
          );
        } else {

          final categories = snapshot.data!;
          return FadeInUp(
            duration: const Duration(milliseconds: 300),
            from: 20,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              primary: false,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(category: category,
                  onTap: (selectedCategory) {
                    // Handle the selected category here
                    print("Selected category: ${selectedCategory?.name}");

                    // Call the parent callback with the selected category
                      onCategorySelected(selectedCategory);
                    },
                );
              },
            ),
          );
        }
      },
    );
  }
}