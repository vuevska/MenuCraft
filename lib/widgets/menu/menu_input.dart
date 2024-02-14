import 'package:flutter/material.dart';

Widget menuInput({
  required String label,
  required TextEditingController controller,
  required IconData icon,
  required bool obscureText,
}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: Colors.white),
      ),
      Expanded(
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white54,
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}
