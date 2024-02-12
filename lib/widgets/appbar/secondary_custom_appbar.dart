import 'package:flutter/material.dart';

class SecondaryCustomAppBar extends StatelessWidget {
  final String title;

  const SecondaryCustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child:
                const Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
