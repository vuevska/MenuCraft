import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/home_page/list_restaurants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: const ListRestaurants(),
    );
  }
}
