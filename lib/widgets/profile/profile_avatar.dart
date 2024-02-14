import 'package:flutter/material.dart';
import 'package:menu_craft/models/providers/user_provider.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key, required this.user});

  final UserProvider user;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    if (widget.user.imageUrl != null && widget.user.imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 70,
        backgroundImage: NetworkImage(widget.user.imageUrl!),
      );
    }
    return CircleAvatar(
      radius: 70,
      backgroundColor: Colors.purple,
      child: Text(
        widget.user.initial(),
        style: const TextStyle(fontSize: 44, color: Colors.white),
      ),
    );
  }
}
