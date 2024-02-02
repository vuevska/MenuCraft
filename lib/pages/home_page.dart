import 'package:flutter/material.dart';

import '../widgets/home_page/card_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: const CardButton(),
      ),
    );
  }
}
