import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/search_page/search_input.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).primaryColor,
        child: const Column(
          children: [
            SearchBarCustom(),
          ],
        ),
      ),
    );

  }
}
