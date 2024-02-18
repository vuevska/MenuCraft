import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/forms/edit_category_form.dart';
import 'package:menu_craft/models/items_category_model.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/view_menu_page.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:toastification/toastification.dart';

class EditCategoryPage extends StatefulWidget {
  final ItemsCategoryModel category;
  final RestaurantModel restaurant;
  const EditCategoryPage(
      {super.key, required this.category, required this.restaurant});

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  final DbRestaurantService _db = DbRestaurantService();
  IconData? _selectedIconData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: [
                const SecondaryCustomAppBar(title: "Edit Category"),
                const SizedBox(height: 15.0),
                EditCategoryForm(
                  category: widget.category,
                  nameController: _nameController,
                  onIconSelected: (icon) {
                    setState(() {
                      _selectedIconData = icon?.icon;
                    });
                  },
                  onPressed: _onPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() async {
    if (_nameController.text.isEmpty) {
      InterfaceUtils.show(context, 'Please fill category name.');
      return;
    }

    _selectedIconData = _selectedIconData ?? IconData(widget.category.icon);
    InterfaceUtils.loadingOverlay(context);

    ItemsCategoryModel updatedCategory = ItemsCategoryModel(
      categoryId: widget.category.categoryId,
      name: _nameController.text,
      icon: _selectedIconData?.codePoint ?? 0,
    );

    try {
      await _db.updateItemsCategory(
        restaurantId: widget.restaurant.restaurantId,
        categoryId: widget.category.categoryId,
        updatedCategory: updatedCategory,
      );

      if (!context.mounted) {
        return;
      }
      InterfaceUtils.show(
        context,
        'Category added successfully!',
        type: ToastificationType.success,
      );
      InterfaceUtils.removeOverlay(context);
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (context) => ViewMenuPage(restaurant: widget.restaurant)),
        (route) => route.isFirst,
      );
    } catch (e) {
      debugPrint('Error editing category: $e');
      InterfaceUtils.show(
        context,
        'An error occurred while editing the category. Please try again later.',
        type: ToastificationType.error,
      );
      InterfaceUtils.removeOverlay(context);
    }
  }
}
