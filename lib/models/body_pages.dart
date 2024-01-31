import 'package:flutter/material.dart';
import 'package:menu_craft/pages/favourites_page.dart';
import 'package:menu_craft/pages/home_page.dart';
import 'package:menu_craft/pages/profile_page.dart';
import 'package:menu_craft/pages/search_page.dart';

class BodyPages {
  static List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    FavouritesPage(),
    ProfilePage()
  ];
}
