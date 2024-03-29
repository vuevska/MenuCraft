import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:menu_craft/models/restaurant_category_model.dart';
import 'package:menu_craft/utils/location_services.dart';
import 'package:menu_craft/widgets/menu/menu_input.dart';

import '../widgets/home_page/pick_location.dart';
import '../utils/data_upward.dart';

class AddMenuForm extends StatefulWidget {
  final TextEditingController nameController;
  final Data<PickedData>? locationController;
  final File? pickedImage;
  final Function(ImageSource) pickImage;
  final Function() onPressed;
  final List<RestaurantCategoryModel> categories;

  final Function(RestaurantCategoryModel?) onCategorySelected;

  const AddMenuForm(
      {super.key,
      required this.nameController,
      required this.locationController,
      required this.pickedImage,
      required this.pickImage,
      required this.onPressed,
      required this.categories,
      required this.onCategorySelected});

  @override
  State<AddMenuForm> createState() => _AddMenuFormState();
}

class _AddMenuFormState extends State<AddMenuForm> {
  void refresh() {
    setState(() {});
  }

  RestaurantCategoryModel? _selectedCategory;

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
                    menuInput(
                      label: 'Restaurant Name',
                      controller: widget.nameController,
                      icon: Icons.restaurant,
                      obscureText: false,
                      //showBorder: false,
                    ),
                    const SizedBox(height: 20.0),
                    DropdownButton<RestaurantCategoryModel>(
                      borderRadius: BorderRadius.circular(8.0),
                      value: _selectedCategory,
                      onChanged: (RestaurantCategoryModel? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                        widget.onCategorySelected(newValue);
                      },
                      items: [
                        const DropdownMenuItem<RestaurantCategoryModel>(
                          value:
                              null, // Set the value to null to represent no selection
                          child: Text(
                            'Choose category',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ...widget.categories
                            .map<DropdownMenuItem<RestaurantCategoryModel>>(
                                (RestaurantCategoryModel value) {
                          return DropdownMenuItem<RestaurantCategoryModel>(
                            value: value,
                            child: Text(
                              value.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (BuildContext context) {
                                return LocationPickPage(
                                  locationController: widget.locationController,
                                  refresh: refresh,
                                );
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Pick Location',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    widget.locationController?.data?.latLong != null
                        ? FutureBuilder(
                            future: LocationService.getAddress(
                              widget.locationController?.data?.latLong
                                      .latitude ??
                                  0.0,
                              widget.locationController?.data?.latLong
                                      .longitude ??
                                  0.0,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Finding location...",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0));
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Location: ${snapshot.data}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            })
                        : const SizedBox.shrink(),
                    const SizedBox(height: 15.0),
                    widget.pickedImage != null
                        ? Column(
                            children: [
                              SizedBox(
                                  height: 200,
                                  child: Image.file(widget.pickedImage!)),
                              const SizedBox(height: 5.0),
                              TextButton.icon(
                                onPressed: () async {
                                  await widget.pickImage(ImageSource.gallery);
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
                              await widget.pickImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.image, color: Colors.white),
                            label: const Text(
                              'Pick an Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ), //TODO: Loading screen
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
