import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/restaurant/view_menu_page.dart';


class RestaurantNameCard extends StatelessWidget {
  final String name;

  const RestaurantNameCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),
      ),
      onTap: () {
        //TODO: open menu (restaurant)
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return const ViewMenuPage();
            },
          ),
        );
      },
    );
  }
}
