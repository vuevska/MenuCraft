import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';
import 'package:menu_craft/widgets/profile/settings/password_reset_form.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            const SecondaryCustomAppBar(title: "Change Password"),
            const SizedBox(height: 20.0),
            Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(29, 27, 32, 1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      PasswordResetForm(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
