import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/search_page/search_input.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Theme.of(context).primaryColor,
          child: const Column(
            children: [
              SearchBarCustom(),
            ],
          ),
        ),
      ]),
    );
  }
}
