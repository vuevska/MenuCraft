import 'package:flutter/material.dart';

import '../../../widgets/profile/settings/profile_setting_row.dart';


class EditProfileSettingsPage extends StatefulWidget {
  const EditProfileSettingsPage({super.key});


  @override
  State<EditProfileSettingsPage> createState() => _EditProfileSettingsPageState();
}

class _EditProfileSettingsPageState extends State<EditProfileSettingsPage> {
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
                  const Text("Edit User Profile",
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
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      ProfileSettingRow(
                        title: "Change Profile Picture",
                        onTap: () {
                          Navigator.pop(context);
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

}
