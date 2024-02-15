import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_category_model.dart';


class CategoryCard extends StatefulWidget {
  final RestaurantCategoryModel category;
  final Function(RestaurantCategoryModel?) onTap;

  const CategoryCard({Key? key,
    required this.category,
    required this.onTap,
  });

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          _pressed = !_pressed;
        });

        widget.onTap(widget.category);

      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: _pressed
              ? Border.all(color: Colors.purple.withOpacity(0.0), width: 3)
              : null, // Change the border color when pressed
          boxShadow: _pressed
              ? [
            BoxShadow(
              color: Colors.purple.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ]
              : null, // Apply the box shadow when pressed
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(widget.category.iconImage)),
              Text(
                widget.category.name,
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