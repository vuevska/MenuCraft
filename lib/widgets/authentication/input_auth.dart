import 'package:flutter/material.dart';

Widget textInputAuth({
  required String label,
  required TextEditingController controller,
  required IconData icon,
  required bool pass,
}) {
  return TextFormField(
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
  );
}
