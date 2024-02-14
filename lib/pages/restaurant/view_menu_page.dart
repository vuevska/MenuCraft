import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/models/items_category_model.dart';
import 'package:menu_craft/pages/restaurant/add_category_page.dart';
import 'package:menu_craft/pages/restaurant/view_menu_items_page.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/utils/generate_qr.dart';

class ViewMenuPage extends StatefulWidget {
  final RestaurantModel restaurant;

  const ViewMenuPage({super.key, required this.restaurant});

  @override
  State<ViewMenuPage> createState() => _ViewMenuPageState();
}

class _ViewMenuPageState extends State<ViewMenuPage> {
  bool isCurrentUserOwner = false;
  final DbRestaurantService _db = DbRestaurantService();

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
    final QRGenOverlay overlay = QRGenOverlay(
        context, widget.restaurant.restaurantId, widget.restaurant.name);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          FadeIn(
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.restaurant.imageUrl),
                    fit: BoxFit.cover,
                    opacity: 0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 0, 0),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white, size: 30.0),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            widget.restaurant.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (isCurrentUserOwner)
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 25.0, 0),
                          child: TextButton(
                            onPressed: () {
                              if (!overlay.isShowing()) {
                                overlay.showOverlay();
                              }
                            },
                            child: const Text("Generate QR Code",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.redAccent)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<ItemsCategoryModel>>(
                    future: _db.getItemsCategoriesForRestaurant(
                        widget.restaurant.restaurantId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final categories = snapshot.data ?? [];
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ViewMenuItemsPage(
                                        category: category,
                                        restaurant: widget.restaurant,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 300),
                                from: 10,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                  child: Card(
                                    color: Colors.grey[50],
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        category.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      leading: Icon(
                                        category.getIconData(),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
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
                Icons.add,
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
