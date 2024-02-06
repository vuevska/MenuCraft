import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';

import '../widgets/home_page/card_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        color: Theme.of(context).primaryColor,
        child: const CardButton(),
      ),
    );
  }
}
