import 'package:flutter/material.dart';

class OwnerMenusPage extends StatefulWidget {
  const OwnerMenusPage({super.key});

  @override
  State<OwnerMenusPage> createState() => _OwnerMenusPageState();
}

class _OwnerMenusPageState extends State<OwnerMenusPage> {
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
