import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/pages/profile/settings/change_password.dart';
import 'package:menu_craft/pages/profile/settings/edit_profile.dart';
import 'package:provider/provider.dart';

import '../../models/providers/user_provider.dart';
import '../../services/auth_service.dart';
import '../../utils/toastification.dart';
import '../../widgets/profile/settings/profile_setting_row.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key, required this.refresh});

  final Function refresh;

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 30.0),
                  ),
                  const SizedBox(width: 10.0),
                  const Text("Profile settings",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(29, 27, 32, 1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      ProfileSettingRow(
                        title: "Edit profile",
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (BuildContext context) {
                                return const EditProfileSettingsPage();
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Builder(builder: (context) {
                        if (AuthService.isEmailUser()) {
                          return Column(
                            children: [
                              ProfileSettingRow(
                                title: "Change Password",
                                onTap: () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (BuildContext context) {
                                        return const ChangePasswordPage();
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      }),

                      ProfileSettingRow(
                        title: "Privacy and Security",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10.0),
                      ProfileSettingRow(
                        title: "About",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10.0),
                      ProfileSettingRow(
                        title: "Logout",
                        logout: true,
                        onTap: () {
                          signOut();
                          Navigator.maybePop(context);
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void signOut() {
    AuthService.signOut().then((value) {
      InterfaceUtils.show(context, "Successfully Logged Out!");
      context.read<UserProvider>().setUser(null);
      widget.refresh();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    });
  }
}
