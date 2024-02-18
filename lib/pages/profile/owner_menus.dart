import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/pages/restaurant/add_menu_page.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:menu_craft/widgets/profile/list_owner_restaurants.dart';

class OwnerMenusPage extends StatefulWidget {
  const OwnerMenusPage({super.key});

  @override
  State<OwnerMenusPage> createState() => _OwnerMenusPageState();
}

class _OwnerMenusPageState extends State<OwnerMenusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: const Column(
          children: [
            SecondaryCustomAppBar(title: "Your Menus"),
            Expanded(
              child: ListOwnerRestaurants(),
            ),
          ],
        ),
      ),
      floatingActionButton: AuthService.isUserLoggedIn()
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) {
                      return const AddMenuPage();
                    },
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
              label: const Text(
                "Create Menu",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            )
          : null,
    );
  }
}
