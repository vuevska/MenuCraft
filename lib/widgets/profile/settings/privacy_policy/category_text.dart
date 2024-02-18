import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class CategoryTextWidget extends StatelessWidget {
  final String filePath;

  const CategoryTextWidget({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadText(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
