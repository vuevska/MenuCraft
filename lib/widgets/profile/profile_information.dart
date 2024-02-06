import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/utils/location_services.dart';
import 'package:provider/provider.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  user.initial(),
                  style: const TextStyle(fontSize: 44, color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                user.fullName ?? "",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Consumer<LocationService>(
                  builder: (context, LocationService location, child) {
                if (location.currentPosition == null) {
                  return const Text("Loading...");
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.pin_drop_rounded,
                      color: Colors.green,
                    ),
                    Text(
                      location.currentAddress,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
