import 'package:flutter/material.dart';

class StaticLoadPage extends StatelessWidget {
  const StaticLoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
