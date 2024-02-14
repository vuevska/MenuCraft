import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/profile/restaurant/input_restaurant.dart';

class AddMenuItemForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final Function() onPressed;

  const AddMenuItemForm({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.onPressed,
  });

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
                    // TextFormField(
                    //   controller: nameController,
                    //   style: const TextStyle(color: Colors.white),
                    //   decoration: const InputDecoration(
                    //     labelText: 'Name',
                    //     labelStyle: TextStyle(color: Colors.white),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.white),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //   ),
                    // ),
                    textInputRest(
                      label: "Name",
                      controller: nameController,
                      icon: Icons.drive_file_rename_outline,
                      pass: false,
                      context: context,
                    ),
                    const SizedBox(height: 15.0),
                    textInputRest(
                      label: "Price",
                      controller: priceController,
                      icon: Icons.attach_money,
                      pass: false,
                      context: context,
                    ),
                    const SizedBox(height: 15.0),
                    textInputRest(
                      label: "Description",
                      controller: descriptionController,
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
                  onPressed: onPressed,
                  child: const Text(
                    'Create Menu Item',
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
