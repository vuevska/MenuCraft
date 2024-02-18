import 'package:flutter/material.dart';

import '../../../widgets/profile/settings/privacy_policy/category_text.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  Map<String, String> categoryFilePaths = {
    'Privacy Policy': 'assets/privacy_policy.txt',
    'Definitions': 'assets/definitions.txt',
    'Personal Data': 'assets/personal_data.txt',
    'Usage Data': 'assets/usage_data.txt',
    'Information from Third-Party Social Media Services':
        'assets/information_from_third_party_social_media_services.txt',
    'Information Collected while Using the Application':
        'assets/information_collected_while_using_the_application.txt',
    'Use of Your Personal Data': 'assets/use_of_your_personal_data.txt',
    'Retention of Your Personal Data':
        'assets/retention_of_your_personal_data.txt',
    'Delete Your Personal Data': 'assets/delete_your_personal_data.txt',
    'Security of Your Personal Data':
        'assets/security_of_your_personal_data.txt',
    'Changes to this Privacy Policy':
        'assets/changes_to_this_privacy_policy.txt',
  };

  Map<String, Widget> categories = {};

  Map<String, bool> categoryExpanded = {};

  @override
  void initState() {
    super.initState();
    categoryFilePaths.forEach((category, filePath) {
      categories[category] = CategoryTextWidget(
          filePath: filePath); // Pass file paths to CategoryTextWidget
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'Privacy and Security',
          style: TextStyle(fontWeight: FontWeight.w600),
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
