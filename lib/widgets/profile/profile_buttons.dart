import 'package:flutter/cupertino.dart';
import 'package:menu_craft/pages/profile/owner_menus.dart';
import 'package:menu_craft/pages/profile/profile_settings_page.dart';
import 'package:menu_craft/widgets/profile/settings/profile_setting_row.dart';

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
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: const Color.fromRGBO(29, 27, 32, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileSettingRow(
            title: "Your Menus",
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return const OwnerMenusPage();
                  },
                ),
              );
            },
          ),
          ProfileSettingRow(
            title: "Profile Settings",
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return ProfileSettingsPage(
                      refresh: widget.refresh,
                    );
                  },
                ),
              );
            },
          ),
          //const SizedBox(height: 40),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.red,
          //   ),
          //   onPressed: () {
          //     AuthService.signOut().then((value) {
          //       InterfaceUtils.show(context, "Successfully Logged Out!");
          //       context.read<UserProvider>().setUser(null);
          //       widget.refresh();
          //     }).catchError((error) {
          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //         content: Text(error.toString()),
          //       ));
          //     });
          //   },
          //   child: const Text(
          //     'Log Out',
          //     style: TextStyle(
          //       fontSize: 16,
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
