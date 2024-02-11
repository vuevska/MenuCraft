import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:menu_craft/widgets/home_page/add_menu_form.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

import '../../services/auth_service.dart';
import '../../utils/data_upward.dart';
import '../profile/profile_page.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final TextEditingController _nameController = TextEditingController();
  final Data<PickedData> _locationController = Data<PickedData>();
  final _picker = ImagePicker();
  final _db = DbRestaurantService();

  File? _pickedImage;

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
                const SecondaryCustomAppBar(title: "Create Menu"),
                const SizedBox(height: 15.0),
                AddMenuForm(
                  nameController: _nameController,
                  locationController: _locationController,
                  pickedImage: _pickedImage,
                  pickImage: _pickImage,
                  onPressed: _onPressed,
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
        _pickedImage == null) {
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
    await _db.addRestaurant(
      name: _nameController.text,
      latitude: _locationController.data?.latLong.latitude ?? 0.0,
      longitude: _locationController.data?.latLong.longitude ?? 0.0,
      imageUrl: imageUrl,
      restaurantId: uuid.v4(),
      owningUserID: AuthService.user!.uid,
      categories: [],
    );

    if (!context.mounted) {
      return;
    }
    InterfaceUtils.show(
      context,
      'Menu added successfully!',
      type: ToastificationType.success,
    );
    InterfaceUtils.removeOverlay(context);
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const ProfilePage()),
      (route) => false,
    );
  }
}
