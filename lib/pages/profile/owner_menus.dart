import 'package:flutter/material.dart';

class OwnerMenus extends StatefulWidget {
  const OwnerMenus({super.key});

  @override
  State<OwnerMenus> createState() => _OwnerMenusState();
}

class _OwnerMenusState extends State<OwnerMenus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
            const Text("Owner Menus"),
          ],
        ),
      ),
    );
  }
}
