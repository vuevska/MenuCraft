import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/items_category_model.dart';
import 'package:menu_craft/models/menu_item_model.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/add_menu_item_page.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/services/db_restaurant_service.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';

class ViewMenuItemsPage extends StatefulWidget {
  final ItemsCategoryModel category;
  final RestaurantModel restaurant;

  const ViewMenuItemsPage({
    super.key,
    required this.category,
    required this.restaurant,
  });

  @override
  State<ViewMenuItemsPage> createState() => _ViewMenuItemsPageState();
}

class _ViewMenuItemsPageState extends State<ViewMenuItemsPage> {
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SecondaryCustomAppBar(title: widget.restaurant.name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FadeInUp(
                duration: const Duration(milliseconds: 500),
                from: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.category.getIconData(),
                      color: Colors.white,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      widget.category.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.0),
                    color: Colors.grey[900],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FutureBuilder<List<MenuItemModel>>(
                      future: _db.getMenuItemsInCategory(
                          widget.restaurant.restaurantId,
                          widget.category.categoryId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'No menu items available',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 0.0),
                              itemCount: snapshot.data!.length,
                              separatorBuilder: (context, index) =>
                                  Divider(color: Colors.grey[800]),
                              itemBuilder: (context, index) {
                                MenuItemModel menuItem = snapshot.data![index];
                                return FadeInUp(
                                  duration: Duration(
                                      milliseconds: (300 + (index * 200))),
                                  from: 20,
                                  child: Container(
                                    color: Colors.grey[900],
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 16.0),
                                    child: ListTile(
                                      title: Text(
                                        menuItem.name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4.0),
                                          Text(
                                            menuItem.description,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 4.0),
                                        ],
                                      ),
                                      trailing: Dance(
                                        duration: Duration(
                                            milliseconds: 50 + (index * 200)),
                                        child: Text(
                                          '\$${menuItem.price.toString()}',
                                          style: const TextStyle(
                                              color: Colors.greenAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isCurrentUserOwner
          ? FloatingActionButton.extended(
              onPressed: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   CupertinoPageRoute(
                //     builder: (context) => AddMenuItemPage(
                //       categoryId: widget.category.categoryId,
                //       restaurant: widget.restaurant,
                //     ),
                //   ),
                //   (route) => false,
                // );
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) {
                      return AddMenuItemPage(
                        categoryId: widget.category.categoryId,
                        restaurant: widget.restaurant,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Create a New Item",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            )
          : null,
    );
  }
}