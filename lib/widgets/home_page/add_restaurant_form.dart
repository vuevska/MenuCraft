import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRestaurantForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController locationController;
  final File? pickedImage;
  final Function(ImageSource) pickImage;
  final Function() onPressed;

  const AddRestaurantForm({
    Key? key,
    required this.nameController,
    required this.locationController,
    required this.pickedImage,
    required this.pickImage,
    required this.onPressed,
  }) : super(key: key);

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
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Name',
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
                    TextFormField(
                      controller: locationController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    pickedImage != null
                        ? Column(
                            children: [
                              SizedBox(
                                  height: 260, child: Image.file(pickedImage!)),
                              const SizedBox(height: 10.0),
                              TextButton.icon(
                                onPressed: () async {
                                  await pickImage(ImageSource.gallery);
                                },
                                icon: const Icon(Icons.image,
                                    color: Colors.white),
                                label: const Text(
                                  'Pick Another Image',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        : TextButton.icon(
                            onPressed: () async {
                              await pickImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.image, color: Colors.white),
                            label: const Text(
                              'Pick an Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: onPressed,
                  child: const Text('Add Restaurant',
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
