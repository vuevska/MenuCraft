import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;


// Modify the CategoryTextWidget class to accept file paths
class CategoryTextWidget extends StatelessWidget {
  final String filePath; // File path for the text file

  const CategoryTextWidget({Key? key, required this.filePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadText(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while reading the file
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Text(
                snapshot.data.toString(),
                style: TextStyle(
                  color: Colors.grey.shade50,
                  fontSize: 15.0,
                ),
              ),
            );
          }
        }
      },
    );
  }

  Future<String> _loadText() async {
    return await rootBundle.loadString(filePath);
  }
}
