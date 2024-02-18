import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/authentication/input_auth.dart';
import 'package:toastification/toastification.dart';

import '../../../services/auth_service.dart';

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm({super.key});

  @override
  State<PasswordResetForm> createState() => _PasswordResetFormState();
}
//TODO: da ne se pokazuva ko ce imame od google sign in

class _PasswordResetFormState extends State<PasswordResetForm> {
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textInputAuth(
          label: "Old Password",
          controller: _oldPassController,
          icon: Icons.lock,
          pass: true,
          context: context,
        ),
        textInputAuth(
          label: "New Password",
          controller: _newPassController,
          icon: Icons.lock_open,
          pass: true,
          context: context,
        ),
        textInputAuth(
          label: "Confirm New Password",
          controller: _confirmPassController,
          icon: Icons.lock_open,
          pass: true,
          context: context,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              AuthService.changePassword(_oldPassController.text,
                      _newPassController.text, _confirmPassController.text).then((value) {
                InterfaceUtils.show(context, "Password changed successfully",type: ToastificationType.success);
                Navigator.maybePop(context);
              })
                  .catchError((onError) {
                onError as FirebaseAuthException;

                InterfaceUtils.show(context, onError.message!,type: ToastificationType.error);
              });
            },
            child: const Text(
              'Change Password',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        )
      ],
    );
  }
}
