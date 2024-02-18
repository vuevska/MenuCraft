import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/view_menu_page.dart';
import 'package:menu_craft/widgets/address_widget.dart';

class FavoriteRestaurantCard extends StatefulWidget {
  final RestaurantModel restaurant;
  final int index;
  final Function onDelete;

  const FavoriteRestaurantCard({
    super.key,
    required this.restaurant,
    required this.onDelete,
    required this.index,
  });

  @override
  State<FavoriteRestaurantCard> createState() => _FavoriteRestaurantCardState();
}

class _FavoriteRestaurantCardState extends State<FavoriteRestaurantCard> {
  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FadeOutDown(
      from: 20,
      duration: const Duration(milliseconds: 300),
      manualTrigger: true,
      controller: (animationCtrl) => animationController = animationCtrl,
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox(
          width: 150.0,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.restaurant.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.restaurant.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        Expanded(
                          child: AddressWidget(
                            latitude: widget.restaurant.latitude,
                            longitude: widget.restaurant.longitude,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150.0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                      return ViewMenuPage(
                                          restaurant: widget.restaurant);
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("View"),
                                  SizedBox(width: 3.0),
                                  Icon(
                                    Icons.restaurant,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                animationController.reset();
                                animationController.forward().then(
                                    (value) => widget.onDelete(widget.index));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[700],
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Remove",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 3.0),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
