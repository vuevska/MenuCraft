import 'package:flutter/material.dart';
import 'package:menu_craft/constants/routes.dart';
import 'package:menu_craft/pages/favourites_page.dart';
import 'package:menu_craft/pages/profile/owner_menus.dart';
import 'package:menu_craft/pages/profile/profile_page.dart';
import 'package:menu_craft/pages/profile/profile_settings_page.dart';
import 'package:menu_craft/pages/root_page.dart';
import 'package:menu_craft/pages/scan_qr_page.dart';
import 'package:menu_craft/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          secondary: const Color.fromRGBO(74, 68, 88, 1),
          primaryContainer: const Color.fromRGBO(74, 68, 88, 1),
          primary: const Color.fromRGBO(16, 20, 24, 1),
        ),
        cardColor: const Color.fromRGBO(236, 230, 240, 1),
        canvasColor: const Color.fromRGBO(16, 20, 24, 1),
        // colorScheme: const ColorScheme.dark(secondary: Color.fromRGBO(74, 68, 88, 1)),
      ),
      initialRoute: initialRoute,
      routes: {
        scannerRoute: (context) => const QrScanner(),
        searchRoute: (context) => const SearchPage(),
        profileRoute: (context) => const ProfilePage(),
        favoritesRoute: (context) => const FavoritesPage(),
        profileSettingsRoute: (context) => const ProfileSettingsPage(),
        profileOwnerMenus: (context) => const OwnerMenus(),
      },
      home: const RootPage(),
    );
  }
}
