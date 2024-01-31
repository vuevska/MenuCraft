import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;

  const ProfileMenuItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
            height: 10,
          ),
        ],
      ),
    );
  }
}
