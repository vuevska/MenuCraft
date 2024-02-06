import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/pages/profile/owner_menus.dart';
import 'package:menu_craft/pages/profile/profile_settings_page.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/profile/menu_item.dart';
import 'package:provider/provider.dart';

class ProfileButtons extends StatefulWidget {
  const ProfileButtons({super.key, required this.refresh});
  final Function refresh;

  @override
  State<ProfileButtons> createState() => _ProfileButtonsState();
}

class _ProfileButtonsState extends State<ProfileButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          ProfileMenuItem(
            title: "Your Menus",
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return const OwnerMenus();
                  },
                ),
              );
            },
          ),
          ProfileMenuItem(
            title: "Profile Settings",
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return const ProfileSettingsPage();
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              AuthService.signOut().then((value) {
                ToastificationUtil.show(context, "Successfully Logged Out!");
                context.read<UserProvider>().setUser(null);
                widget.refresh();
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(error.toString()),
                ));
              });
            },
            child: const Text(
              'Log Out',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
