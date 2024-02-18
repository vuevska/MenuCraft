import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/profile/restaurant/input_restaurant.dart';

class EditMenuItemForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final Function() onPressed;

  const EditMenuItemForm({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.onPressed,
  });

  @override
  State<EditMenuItemForm> createState() => _EditMenuItemFormState();
}

class _EditMenuItemFormState extends State<EditMenuItemForm> {
  void refresh() {
    setState(() {});
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
                    textInputRest(
                      label: "Name",
                      controller: widget.nameController,
                      icon: Icons.drive_file_rename_outline,
                      pass: false,
                      context: context,
                    ),
                    const SizedBox(height: 15.0),
                    textInputRest(
                      label: "Price",
                      controller: widget.priceController,
                      icon: Icons.attach_money,
                      pass: false,
                      context: context,
                    ),
                    const SizedBox(height: 15.0),
                    textInputRest(
                      label: "Description",
                      controller: widget.descriptionController,
                      icon: Icons.description,
                      pass: false,
                      context: context,
                      lines: 5,
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
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
