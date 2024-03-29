import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/pages/authentication/log_in.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/utils/location_services.dart';
import 'package:menu_craft/widgets/profile/profile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      if (AuthService.isUserLoggedIn() && userProvider.user != null) {
        context
            .read<LocationService>()
            .determinePosition()
            .catchError((onError) {
          //TODO: mozebi i ovde error code
        });
        return Profile(refresh: refresh);
      } else {
        return LoginPage(refresh: refresh);
      }
    });
  }
}
