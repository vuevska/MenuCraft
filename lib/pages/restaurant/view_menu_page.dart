import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/models/category_model.dart';
import 'package:menu_craft/pages/restaurant/add_category_page.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/services/db_service.dart';
import 'package:menu_craft/utils/generate_qr.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';

class ViewMenuPage extends StatefulWidget {
  final RestaurantModel restaurant;

  const ViewMenuPage({super.key, required this.restaurant});

  @override
  State<ViewMenuPage> createState() => _ViewMenuPageState();
}

class _ViewMenuPageState extends State<ViewMenuPage> {
  bool isCurrentUserOwner = false;
  final DbAuthService _db = DbAuthService();

  @override
  void initState() {
    super.initState();
    checkOwnership();
  }

  void checkOwnership() {
    String? loggedInUserId = AuthService.getCurrentUser()?.uid;
    if (loggedInUserId == widget.restaurant.owningUserID) {
      setState(() {
        isCurrentUserOwner = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final QRGenOverlay overlay = QRGenOverlay(context, widget.restaurant.restaurantId, widget.restaurant.name);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SecondaryCustomAppBar(title: widget.restaurant.name),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Categories:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<CategoryModel>>(
                future: _db
                    .getCategoriesForRestaurant(widget.restaurant.restaurantId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final categories = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          title: Text(
                            category.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (!overlay.isShowing()) {
                  overlay.showOverlay();
                }
              },
              child: Text(
                  "Generate QR Code for Menu"), //TODO: ce go premestime ama testiram
            ),
          ],
        ),
      ),
      floatingActionButton: isCurrentUserOwner
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) {
                      return AddCategoryPage(restaurant: widget.restaurant);
                    },
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
              label: const Text(
                "Create a New Category",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            )
          : null,
    );
  }
}
