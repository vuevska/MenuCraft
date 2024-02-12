import 'package:flutter/material.dart';
import 'package:menu_craft/models/category_model.dart';



class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

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