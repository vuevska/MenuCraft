import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import 'package:menu_craft/widgets/address_widget.dart';

class FavoriteRestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  final int index;
  final Function onDelete;
  late AnimationController animationController;

  FavoriteRestaurantCard({
    super.key,
    required this.restaurant,
    required this.onDelete,
    required this.index,
  });

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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(restaurant.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            restaurant.name,
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
                                  latitude: restaurant.latitude,
                                  longitude: restaurant.longitude,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: () {
                      animationController.reset();
                      animationController
                          .forward()
                          .then((value) => onDelete(index));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Remove"),
                        Icon(Icons.star),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
