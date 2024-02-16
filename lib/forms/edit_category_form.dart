import 'package:flutter/material.dart';
import 'package:flutter_iconpicker_plus/flutter_iconpicker.dart';
import 'package:menu_craft/models/items_category_model.dart';
import 'package:menu_craft/widgets/profile/restaurant/input_restaurant.dart';

class EditCategoryForm extends StatefulWidget {
  final TextEditingController nameController;
  final Function(Icon?) onIconSelected;
  final Function() onPressed;
  final ItemsCategoryModel category;
  const EditCategoryForm({
    super.key,
    required this.nameController,
    required this.onPressed,
    required this.onIconSelected,
    required this.category,
  });

  @override
  State<EditCategoryForm> createState() => _EditCategoryFormState();
}

class _EditCategoryFormState extends State<EditCategoryForm> {
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
    widget.nameController.value = widget.nameController.value.text.isEmpty
        ? TextEditingValue(text: widget.category.name)
        : widget.nameController.value;

    _icon ??= Icon(widget.category.getIconData());
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
                    textInputRest(
                      label: "Category Name",
                      controller: widget.nameController,
                      icon: Icons.drag_indicator,
                      pass: false,
                      context: context,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_icon != null)
                          Icon(_icon!.icon, size: 50, color: Colors.white),
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
                  child: const Text('Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
