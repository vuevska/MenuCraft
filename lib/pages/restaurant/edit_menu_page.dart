import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:menu_craft/models/restaurant_category_model.dart';
import 'package:menu_craft/pages/profile/owner_menus.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

import '../../forms/edit_menu_form.dart';
import '../../services/auth_service.dart';
import '../../utils/data_upward.dart';

class EditMenuPage extends StatefulWidget {
  final String restaurantId;
  const EditMenuPage({super.key, required this.restaurantId});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final TextEditingController _nameController = TextEditingController();
  final Data<PickedData> _locationController = Data<PickedData>();
  final _picker = ImagePicker();
  final _db = DbRestaurantService();


  File? _pickedImage;
  RestaurantCategoryModel? _selectedCategory;

  List<RestaurantCategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await DbRestaurantService().getAllCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }

  void _onCategorySelected(RestaurantCategoryModel? category) {
    setState(() {
      _selectedCategory = category;
    });
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
                const SecondaryCustomAppBar(title: "Edit Menu"),
                const SizedBox(height: 15.0),
                EditMenuForm(
                  nameController: _nameController,
                  locationController: _locationController,
                  pickedImage: _pickedImage,
                  pickImage: _pickImage,
                  onPressed: _onPressed,
                  categories: _categories,
                  onCategorySelected: _onCategorySelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(
      source: source,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  void _onPressed() async {
    if (_nameController.text.isEmpty ||
        _locationController.data == null ||
        _locationController.data?.latLong == null ||
        _pickedImage == null ||
        _selectedCategory == null) {
      InterfaceUtils.show(
        context,
        'Please fill all fields and pick an image.',
      );
      return;
    }
    InterfaceUtils.loadingOverlay(context);

    const uuid = Uuid();
    final imageUrl = await _db.uploadRestaurantImage(
      uuid.v4(),
      _pickedImage!,
    );
    await _db.updateRestaurant(
      name: _nameController.text,
      latitude: _locationController.data?.latLong.latitude ?? 0.0,
      longitude: _locationController.data?.latLong.longitude ?? 0.0,
      imageUrl: imageUrl,
      restaurantId: widget.restaurantId,
      owningUserID: AuthService.user!.uid,
      category: _selectedCategory!.name,
      //categories: _categories,
    );

    if (!context.mounted) {
      return;
    }
    InterfaceUtils.show(
      context,
      'Menu edited successfully!',
      type: ToastificationType.success,
    );
    InterfaceUtils.removeOverlay(context);
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const OwnerMenusPage()),
          (route) => route.isFirst,
    );
  }
}
