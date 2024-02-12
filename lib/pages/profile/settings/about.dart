import 'package:flutter/material.dart';

import '../../../widgets/profile/settings/privacy_policy/category_text.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // Define a map to store category and its corresponding text
  Map<String, Widget> categories = {
    'About Us': const CategoryTextWidget(category: 'About Us'),
    'Core values': const CategoryTextWidget(category: 'Core values'),
    'Contact': const CategoryTextWidget(category: 'Contact'),
  };

  Map<String, bool> categoryExpanded = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.purple.shade50,
      ),
      body: ListView(
        children: categories.keys.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(
                  category,
                  style: TextStyle(
                      color: Colors.grey.shade50,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  categoryExpanded[category] == true
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                ),
                onTap: () {
                  setState(() {
                    // Toggle category expansion state
                    categoryExpanded[category] =
                    !(categoryExpanded[category] ?? false);
                  });
                },
              ),
              // Display text if category is expanded
              if (categoryExpanded[category] == true)
                categories[category]!,
              const Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }
}

