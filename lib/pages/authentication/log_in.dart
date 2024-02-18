import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/pages/authentication/send_pass_reset.dart';
import 'package:menu_craft/pages/authentication/sign_up.dart';
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
      return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            //TODO: ko ce vnesis gresen login da go snema loading
            body: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BounceInDown(
                      from: 25,
                      duration: const Duration(milliseconds: 700),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          image: const AssetImage('images/loginImage.jpg'),
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
                        child: Text("Login",
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
                      pass: false,
                      context: context,
                    ),
                    textInputAuth(
                      label: "Password",
                      controller: _passController,
                      icon: Icons.password,
                      pass: true,
                      context: context,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            AuthService.signInWithMail(context,
                                    _emailController.text, _passController.text)
                                .then((value) {
                              context.read<UserProvider>().setUser(value);
        
                              widget.refresh();
                            }).catchError((onError) {
                              onError as FirebaseAuthException;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(onError.message ?? "")),
                              );
                              setState(() {
                                _isLoading = false;
                              });
                            });
                            setState(() {
                              _isLoading = true;
                            });
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/signup');
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (BuildContext context) {
                                return const PasswordResetPage();
                              },
                            ),
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(Colors.grey),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        child: const Text("Forgot Password? Reset it!"),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/signup');
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (BuildContext context) {
                                return const SignUp();
                              },
                            ),
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.amberAccent),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        child: const Text("Don't have an account? Create one!"),
                      ),
                    ),
                    SignInButton(
                      Buttons.googleDark,
                      onPressed: () {
                        AuthService.signInWithGoogle().then((value) {
                          context.read<UserProvider>().setUser(value);
        
                          widget.refresh();
                        });
                      },
                    ),
                  ],
                ),
              ),
            )),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }
}
