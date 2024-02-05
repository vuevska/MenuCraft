import 'package:flutter/material.dart';
import 'package:menu_craft/pages/authentication/log_in.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/utils/location_services.dart';
import 'package:menu_craft/widgets/profile/profile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (AuthService.isUserLoggedIn()) {
      context.read<LocationService>().determinePosition();
      return Profile(refresh: refresh);
    } else {
      return LoginPage(refresh: refresh);
    }
  }
}

// class SectionItem extends StatelessWidget {
//   final String title;
//
//   const SectionItem({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
