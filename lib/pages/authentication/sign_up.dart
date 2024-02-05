import 'package:flutter/material.dart';
import 'package:menu_craft/utils/toastification.dart';
import 'package:menu_craft/widgets/authentication/input_auth.dart';

import '../../services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO:  da se sredi malce izgledov
        body: Container(
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            textInputAuth(
                label: "Email",
                controller: _emailController,
                icon: Icons.email,
                pass: false),
            textInputAuth(
                label: "Name",
                controller: _nameController,
                icon: Icons.account_box,
                pass: false),
            textInputAuth(
                label: "Surname",
                controller: _surnameController,
                icon: Icons.account_box,
                pass: false),
            textInputAuth(
                label: "Password",
                controller: _passController,
                icon: Icons.password,
                pass: true),

            textInputAuth(
                label: "Confirm Password",
                controller: _passConfirmController,
                icon: Icons.password,
                pass: true),

            ElevatedButton(
              onPressed: () {
                if (_passController.text == _passConfirmController.text) {
                  AuthService.signUpWithMail(
                    context,
                    _emailController.text,
                    _passController.text,
                    _nameController.text,
                    _surnameController.text,
                  ).then((value) {
                    if (value != null) {
                      ToastificationUtil.show(
                          context, "Please verify your email address");
                      Navigator.maybePop(context);
                    }
                  });
                } //TODO: Add error handling
                //TODO: Add password strength check
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              child: const Text("Log In"),
            )
            // IconButton(
            //   onPressed: () => {},
            //   icon: Icons.,
            //   color: Colors.white,
            //   iconSize: 30,
            // ), TODO: Add social media login
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _passController.dispose();
    _passConfirmController.dispose();
  }
}
