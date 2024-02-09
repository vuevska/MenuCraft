import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/pages/profile/profile_page.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:menu_craft/widgets/profile/settings/delete_modal.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../../../services/db_service.dart';
import '../../../widgets/profile/settings/profile_setting_row.dart';

class EditProfileSettingsPage extends StatefulWidget {
  const EditProfileSettingsPage({super.key});

  @override
  State<EditProfileSettingsPage> createState() =>
      _EditProfileSettingsPageState();
}

class _EditProfileSettingsPageState extends State<EditProfileSettingsPage> {
  final _picker = ImagePicker();
  final _db = DbAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            const SecondaryCustomAppBar(title: "Edit User Profile"),
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
                        title: "Change Profile Picture",
                        onTap: () async {
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 1024,
                              maxWidth: 1024);

                          if (image?.name == null) {
                            return;
                          }
                          if (context.mounted) {
                            InterfaceUtils.loadingOverlay(context);
                          }

                          if (image != null) {
                            final file = File(image.path);
                            await _db
                                .addLocalImageToUser(
                                    AuthService.user!.uid, file)
                                .then((value) {
                              InterfaceUtils.removeOverlay(context);

                              context.read<UserProvider>().updateImage(value);
                              InterfaceUtils.show(context,
                                  "You have changed your profile picture!",
                                  type: ToastificationType.success);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const ProfilePage()),
                                  (route) => false);
                            }).catchError((onError) {
                              InterfaceUtils.show(context, onError.toString());
                              InterfaceUtils.removeOverlay(context);
                            });
                          }
                        },
                      ),
                      ProfileSettingRow(
                        title: "Delete Profile",
                        onTap: () async {
                          PersistentNavBarNavigator.pushDynamicScreen(
                            context,
                            screen: CupertinoPageRoute(
                                builder: (context) =>
                                    DeleteAccountModal(db: _db)),
                            withNavBar: true,
                          );
                        },
                        logout: true,
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
