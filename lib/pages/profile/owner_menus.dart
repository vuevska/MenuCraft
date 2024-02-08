import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/pages/restaurant/add_restaurant.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';

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
        child: Column(
          children: [
            const SecondaryCustomAppBar(title: "Your Menus"),
            const SizedBox(height: 20.0),
            Container(),
          ],
        ),
      ),
      floatingActionButton: AuthService.isUserLoggedIn()
          ? FloatingActionButton.extended(
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
                "Add Menu",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            )
          : null, // If user is not logged in, don't show the button
    );
  }
}
