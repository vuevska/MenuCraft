import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Widget textInputAuth({
  required String label,
  required TextEditingController controller,
  required IconData icon,
  required bool pass,
  required BuildContext context,
}) {
  print(MediaQuery.of(context).viewInsets.bottom);
  return FadeInDown(
    duration: const Duration(milliseconds: 300),
    from: 10,
    child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 1),
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(icon),
          iconColor: Colors.white,
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.white,
        ),
        obscureText: pass,
        enableSuggestions: !pass,
        autocorrect: !pass,
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        }),
  );
}
