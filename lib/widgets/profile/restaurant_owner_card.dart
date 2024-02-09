import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/view_menu_page.dart';
import 'package:menu_craft/widgets/address_widget.dart';
import 'package:menu_craft/widgets/home_page/favorite_button.dart';

class RestaurantOwnerCard extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantOwnerCard({super.key, required this.restaurant});

  @override
  _RestaurantOwnerCardState createState() => _RestaurantOwnerCardState();
}

class _RestaurantOwnerCardState extends State<RestaurantOwnerCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
        child: Card(
          child: Padding(
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
                Text(
                  widget.restaurant.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: AddressWidget(
                        latitude: widget.restaurant.latitude,
                        longitude: widget.restaurant.longitude,
                      ),
                    ),
                  ],
                ),
                if (_expanded) ...[
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            backgroundColor: Colors.purple[50],
                          ),
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
                          icon: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "View Menu",
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ),
                      ),
                      // TODO: za Maria ova za promena na restoranot
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            backgroundColor: Colors.purple[50],
                          ),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.mode_edit_sharp,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Edit Restaurant",
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
