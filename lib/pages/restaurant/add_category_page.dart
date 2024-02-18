import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/forms/add_category_form.dart';
import 'package:menu_craft/models/items_category_model.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/view_menu_page.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class AddCategoryPage extends StatefulWidget {
  final RestaurantModel restaurant;
  const AddCategoryPage({super.key, required this.restaurant});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
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
                const SecondaryCustomAppBar(title: "Create Category"),
                const SizedBox(height: 15.0),
                AddCategoryForm(
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
    if (_selectedIconData == null) {
      InterfaceUtils.show(context, 'Please pick an icon.');
      return;
    }
    InterfaceUtils.loadingOverlay(context);

    const uuid = Uuid();
    ItemsCategoryModel newCategory = ItemsCategoryModel(
      categoryId: uuid.v4(),
      name: _nameController.text,
      icon: _selectedIconData?.codePoint ?? 0,
    );

    try {
      Map<String, dynamic> categoryMap = newCategory.toMap();

      await _db.addItemsCategoryToRestaurant(
          widget.restaurant.restaurantId, categoryMap);
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
      debugPrint('Error adding category: $e');
      InterfaceUtils.show(
        context,
        'An error occurred while adding the category. Please try again later.',
        type: ToastificationType.error,
      );
      InterfaceUtils.removeOverlay(context);
    }
  }
}
