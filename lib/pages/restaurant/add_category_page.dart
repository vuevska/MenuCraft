import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker_plus/flutter_iconpicker.dart';
import 'package:menu_craft/constants/routes.dart';
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
      // await _db.addCategory(newCategory);

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

class AddCategoryForm extends StatefulWidget {
  final TextEditingController nameController;
  final Function(Icon?) onIconSelected;
  final Function() onPressed;

  const AddCategoryForm({
    super.key,
    required this.nameController,
    required this.onIconSelected,
    required this.onPressed,
  });

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  Icon? _icon;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    if (icon != null) {
      _icon = Icon(icon);
      widget.onIconSelected(_icon);
      setState(() {});
    }

    debugPrint('Picked Icon:  $icon');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(29, 27, 32, 1),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: widget.nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Category Name',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_icon != null) Icon(_icon!.icon, size: 50),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: _pickIcon,
                          child: const Text(
                            'Pick Icon',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: widget.onPressed,
                  child: const Text('Create',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
