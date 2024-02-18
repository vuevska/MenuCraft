import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Widget textInputRest({
  required String label,
  required TextEditingController controller,
  required IconData icon,
  required bool pass,
  required BuildContext context,
  int lines = 1,
}) {
  return FadeInDown(
    duration: const Duration(milliseconds: 300),
    from: 50,
    child: TextFormField(
        scrollPadding: const EdgeInsets.only(
          bottom: 1,
        ),
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
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
        maxLines: lines,
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        }),

  );
}
