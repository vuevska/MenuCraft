import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/pages/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../../../models/providers/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../../utils/toastification.dart';

class DeleteAccountModal extends StatelessWidget {
  const DeleteAccountModal({super.key, required this.db});

  final db;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure?"),
      content: const Text("This action is irreversible"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            await db.deleteUser(AuthService.user!.uid).then((value) async {
              InterfaceUtils.show(context, "You have deleted your profile!",
                  type: ToastificationType.success);
              await AuthService.deleteAccount();
              if (!context.mounted) {
                return;
              }
              context.read<UserProvider>().setUser(null);

              Navigator.of(context).popUntil(ModalRoute.withName("/"));
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return ProfilePage();
                  },
                ),
                (_) => false,
              );
//TODO: nekoj popameten da se najdi i da go popraj ova
// Navigator.popUntil(context, (route) => )
            }).catchError((onError) {
              InterfaceUtils.show(context, onError.toString());
            });
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
