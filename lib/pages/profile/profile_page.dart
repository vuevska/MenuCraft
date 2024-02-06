import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/profile/profile_buttons.dart';
import 'package:menu_craft/widgets/profile/profile_information.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileInformation(),
              ProfileButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
