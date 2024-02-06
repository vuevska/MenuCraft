import 'package:flutter/material.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      margin: const EdgeInsets.only(bottom: 10),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.purple,
            child: Text(
              'JD',
              style: TextStyle(
                fontSize: 44,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Jane Doe',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pin_drop_rounded,
                color: Colors.green,
              ),
              Text(
                'Skopje, MK',
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
