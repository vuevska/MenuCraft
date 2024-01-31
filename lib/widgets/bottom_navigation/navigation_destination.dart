import 'package:flutter/material.dart';

Widget navigationDestination(Icon icon) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: NavigationDestination(
      icon: icon,
      label: '',
    ),
  );
}
