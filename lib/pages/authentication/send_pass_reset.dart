import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../services/auth_service.dart';
import '../../utils/toastification.dart';
import '../../widgets/authentication/input_auth.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 30.0),
                  ),
                  const SizedBox(width: 10.0),
                  const Text("Password Reset",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(29, 27, 32, 1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      textInputAuth(
                        label: "Email Address",
                        controller: _emailController,
                        icon: Icons.email_outlined,
                        pass: false,
                        context: context,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            AuthService.sendPasswordResetEmail(
                                    _emailController.text)
                                .then((value) {
                              InterfaceUtils.show(
                                  context, "Password reset email sent!",
                                  type: ToastificationType.success);
                              Navigator.maybePop(context);
                            }).catchError((onError) {
                              onError as FirebaseAuthException;

                              InterfaceUtils.show(context, onError.message!,
                                  type: ToastificationType.error);
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
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
