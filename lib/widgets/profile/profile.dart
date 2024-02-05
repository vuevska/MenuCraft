import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:provider/provider.dart';

import 'menu_item.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.refresh});

  final Function refresh;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              margin: const EdgeInsets.only(bottom: 10),
              child: Consumer<UserProvider>(
                builder: (context, user, child) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.purple,
                        child: Text(
                          user.initial ?? "",
                          style: const TextStyle(fontSize: 44, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        user.fullName ?? "",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pin_drop_rounded,
                            color: Colors.green,
                          ),
                          Text(
                            'Skopje, MK', //TODO: da se zemi od user
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: const Color.fromRGBO(29, 27, 32, 1),
              ),
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ProfileMenuItem(title: "Your Menus"),
                  const ProfileMenuItem(title: "Favorite Menus"),
                  const ProfileMenuItem(title: "Profile Settings"),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      AuthService.signOut().then((value) {
                        ToastificationUtil.show(
                            context, "Successfully Logged Out!");
                        context.read<UserProvider>().setUser(null);
                        widget.refresh();
                      });
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
