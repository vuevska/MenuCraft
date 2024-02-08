import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/pages/restaurant/view_menu_page.dart';
import 'package:menu_craft/utils/location_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpandableCard extends StatefulWidget {
  final RestaurantModel restaurant;

  const ExpandableCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
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
                      child: FutureBuilder<String>(
                        future: LocationService.getAddress(
                          widget.restaurant.latitude,
                          widget.restaurant.longitude,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Finding location...");
                          }
                          if (snapshot.hasError) {
                            return const Text('Error finding location');
                          }
                          if (snapshot.hasData) {
                            return GestureDetector(
                              onLongPress: () {
                                launchUrl(
                                  Uri.parse(
                                    'https://www.google.com/maps/search/?api=1&query=${widget.restaurant.latitude},${widget.restaurant.longitude}',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4.0),
                                  Text(
                                    snapshot.data!,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
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
                                  return const ViewMenuPage();
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
                            // TODO: Dodadi funkcija tuka
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Add to Favorites",
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
