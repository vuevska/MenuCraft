import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/view_menu_page.dart';
import 'package:menu_craft/widgets/address_widget.dart';
import 'package:menu_craft/widgets/profile/restaurant/delete_restaurant_modal.dart';

import '../../pages/restaurant/edit_menu_page.dart';
import '../../services/db_restaurant_service.dart';
import '../../utils/toastification.dart';

class RestaurantOwnerCard extends StatefulWidget {
  final RestaurantModel restaurant;
  final Function refresh;

  const RestaurantOwnerCard({
    super.key,
    required this.restaurant,
    required this.refresh,
  });

  @override
  State<RestaurantOwnerCard> createState() => _RestaurantOwnerCardState();
}

class _RestaurantOwnerCardState extends State<RestaurantOwnerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return ViewMenuPage(restaurant: widget.restaurant);
            },
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 155.0,
                    child: Image(
                      image: NetworkImage(widget.restaurant.imageUrl),
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text("Error loading image"),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          widget.restaurant.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.grey[700],
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditMenuPage(
                                      restaurant: widget.restaurant),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DeleteConfirmationDialog(
                                    onConfirm: () async {
                                      try {
                                        await DbRestaurantService()
                                            .deleteRestaurant(
                                                widget.restaurant.restaurantId)
                                            .catchError((onError) {
                                          InterfaceUtils.show(
                                              context, onError.toString());
                                        });
                                        widget.refresh();
                                        if (!context.mounted) {
                                          return;
                                        }
                                        Navigator.of(context).pop();
                                      } catch (e) {
                                        print('Error deleting restaurant: $e');
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      Expanded(
                        child: DefaultTextStyle(
                          style: const TextStyle(color: Colors.grey),
                          child: AddressWidget(
                            latitude: widget.restaurant.latitude,
                            longitude: widget.restaurant.longitude,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
