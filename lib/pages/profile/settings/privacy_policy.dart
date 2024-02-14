import 'package:flutter/material.dart';

import '../../../widgets/profile/settings/privacy_policy/category_text.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  // Define a map to store category and its corresponding text
  Map<String, Widget> categories = {
    'Privacy Policy': const CategoryTextWidget(category: 'Privacy Policy'),
    'Definitions': const CategoryTextWidget(category: 'Definitions'),
    'Personal Data': const CategoryTextWidget(category: 'Personal Data'),
    'Usage Data': const CategoryTextWidget(category: 'Usage Data'),
    'Information from Third-Party Social Media Services':
        const CategoryTextWidget(
            category: 'Information from Third-Party Social Media Services'),
    'Information Collected while Using the Application':
        const CategoryTextWidget(
            category: 'Information Collected while Using the Application'),
    'Use of Your Personal Data':
        const CategoryTextWidget(category: 'Use of Your Personal Data'),
    'Retention of Your Personal Data':
        const CategoryTextWidget(category: 'Retention of Your Personal Data'),
    'Delete Your Personal Data':
        const CategoryTextWidget(category: 'Delete Your Personal Data'),
    'Security of Your Personal Data':
        const CategoryTextWidget(category: 'Security of Your Personal Data'),
    'Changes to this Privacy Policy':
        const CategoryTextWidget(category: 'Changes to this Privacy Policy'),
  };

  Map<String, bool> categoryExpanded = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Privacy and Security'),
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
                      fontWeight: FontWeight.w600),
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
              if (categoryExpanded[category] == true) categories[category]!,
              const Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
