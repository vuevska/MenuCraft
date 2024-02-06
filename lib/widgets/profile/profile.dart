import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/profile/profile_buttons.dart';
import 'package:menu_craft/widgets/profile/profile_information.dart';

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
      appBar: const CustomAppBar(),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfileInformation(),
              ProfileButtons(
                refresh: widget.refresh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
