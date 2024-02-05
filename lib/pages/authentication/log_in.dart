import 'package:flutter/material.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/widgets/authentication/input_auth.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../models/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  final Function refresh;

  const LoginPage({super.key, required this.refresh});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Scaffold(
          //TODO: ko ce vnesis gresen login da go snema loading
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
                  label: "Password",
                  controller: _passController,
                  icon: Icons.password,
                  pass: true),
              ElevatedButton(
                onPressed: () {
                  AuthService.signInWithMail(
                          context, _emailController.text, _passController.text)
                      .then((value) {

                    context.read<UserProvider>().setUser(value);

                    widget.refresh();
                  }).catchError((onError) {
                     //TODO: da se sredi error handling
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(onError.toString()),
                    ));
                    setState(() {
                      _isLoading = false;
                    });
                  });
                  setState(() {
                    _isLoading = true;
                  });
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text("Sign Up"),
              ),
              SignInButton(
                Buttons.googleDark,
                onPressed: () {
                  AuthService.signInWithGoogle()
                      .then((value) => widget.refresh());
                },
              ),
            ],
          ),
        ),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }
}
