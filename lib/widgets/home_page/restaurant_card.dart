import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/favorite_provider.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/view_menu_page.dart';
import 'package:menu_craft/widgets/address_widget.dart';
import 'package:menu_craft/widgets/home_page/favorite_button.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
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
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.restaurant.name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
            Positioned(
              top: 8.0,
              right: 8.0,
              child: FavoriteButton(
                restaurantId: widget.restaurant.restaurantId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
