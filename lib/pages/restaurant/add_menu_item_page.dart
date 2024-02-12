// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:menu_craft/models/items_category_model.dart';
import 'package:menu_craft/models/menu_item_model.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/view_menu_items_page.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:menu_craft/forms/add_menu_item_form.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class AddMenuItemPage extends StatefulWidget {
  final String categoryId;
  final RestaurantModel restaurant;

  const AddMenuItemPage({
    super.key,
    required this.categoryId,
    required this.restaurant,
  });

  @override
  State<AddMenuItemPage> createState() => _AddMenuItemPageState();
}

class _AddMenuItemPageState extends State<AddMenuItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DbRestaurantService _db = DbRestaurantService();

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
                const SecondaryCustomAppBar(title: "Add Menu Item"),
                const SizedBox(height: 15.0),
                AddMenuItemForm(
                  nameController: _nameController,
                  priceController: _priceController,
                  descriptionController: _descriptionController,
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
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      InterfaceUtils.show(context, 'Please fill all fields.');
      return;
    }
    InterfaceUtils.loadingOverlay(context);

    const uuid = Uuid();

    try {
      final menuItem = MenuItemModel(
        menuItemId: uuid.v4(),
        name: _nameController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
      );

      await _db.addMenuItemToCategory(
        widget.restaurant.restaurantId,
        widget.categoryId,
        menuItem,
      );

      InterfaceUtils.show(
        context,
        'Menu item added successfully!',
        type: ToastificationType.success,
      );
      InterfaceUtils.removeOverlay(context);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ViewMenuItemsPage(
            category: ItemsCategoryModel(
              categoryId: widget.categoryId,
              name: "",
              icon: Icons.restaurant.codePoint,
            ),
            restaurant: widget.restaurant,
          ),
        ),
        (route) => route.isFirst,
      );
    } catch (e) {
      debugPrint('Error adding menu item: $e');
      InterfaceUtils.show(
        context,
        'Failed to add menu item. Please try again.',
        type: ToastificationType.error,
      );
      InterfaceUtils.removeOverlay(context);
    }
  }
}
