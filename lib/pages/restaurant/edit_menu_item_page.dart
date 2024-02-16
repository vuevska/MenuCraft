import 'package:flutter/material.dart';
import 'package:menu_craft/forms/edi_menu_item_form.dart';
import 'package:menu_craft/models/menu_item_model.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:toastification/toastification.dart';

class EditMenuItemPage extends StatefulWidget {
  final String categoryId;
  final String restaurantId;
  final MenuItemModel menuItem;

  const EditMenuItemPage({
    super.key,
    required this.categoryId,
    required this.restaurantId,
    required this.menuItem,
  });

  @override
  _EditMenuItemPageState createState() => _EditMenuItemPageState();
}

class _EditMenuItemPageState extends State<EditMenuItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DbRestaurantService _db = DbRestaurantService();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.menuItem.name;
    _priceController.text = widget.menuItem.price.toString();
    _descriptionController.text = widget.menuItem.description;
  }

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
                const SecondaryCustomAppBar(title: "Edit Menu Item"),
                const SizedBox(height: 15.0),
                EditMenuItemForm(
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

    try {
      final updatedMenuItem = MenuItemModel(
        menuItemId: widget.menuItem.menuItemId,
        name: _nameController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
      );

      await _db.updateMenuItem(
        widget.restaurantId,
        widget.categoryId,
        updatedMenuItem,
      );

      InterfaceUtils.show(
        context,
        'Menu item updated successfully!',
        type: ToastificationType.success,
      );
      InterfaceUtils.removeOverlay(context);

      Navigator.pop(context, true);
    } catch (e) {
      debugPrint('Error updating menu item: $e');
      InterfaceUtils.show(
        context,
        'Failed to update menu item. Please try again.',
        type: ToastificationType.error,
      );
      InterfaceUtils.removeOverlay(context);
    }
  }
}
