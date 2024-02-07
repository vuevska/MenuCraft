import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/pages/add_restaurant.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';

import '../widgets/home_page/card_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        color: Theme.of(context).primaryColor,
        child: const CardButton(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) {
                return const AddRestaurantPage();
              },
            ),
          );
        },
        icon: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        label: const Text(
          "Add Restaurant",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
