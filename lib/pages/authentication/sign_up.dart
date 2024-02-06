import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                BounceInDown(
                  from: 25,
                  duration: const Duration(milliseconds: 700),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      image: const AssetImage('images/signUpImage.jpg'),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                FadeInDown(
                  duration: const Duration(milliseconds: 200),
                  from: 25,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                  ),
                ),
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
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
                        }).catchError((onError) {
                          onError as FirebaseAuthException;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(onError.message ?? "")),
                          );
                        });
                      }
                      //TODO: Add password strength check
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.grey),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    child: const Text("You already have an account? Log in!"),
                  ),
                )
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
