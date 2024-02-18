import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/user_provider.dart';
import 'package:menu_craft/utils/location_services.dart';
import 'package:menu_craft/widgets/profile/profile_avatar.dart';
import 'package:provider/provider.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontWeight: FontWeight.w300),
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        margin: const EdgeInsets.only(bottom: 10),
        child: Consumer<UserProvider>(
          builder: (context, user, child) {
            return Column(
              children: [
                ProfileAvatar(user: user),
                const SizedBox(height: 15),
                Text(
                  user.fullName ?? "",
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                Consumer<LocationService>(
                  builder: (context, LocationService location, child) {
                    if (location.currentPosition == null) {
                      return const SizedBox(
                        height: 20,
                      );
                    }

                    return Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.pin_drop_rounded,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                location.currentAddress,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
