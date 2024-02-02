import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/profile/menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              margin: const EdgeInsets.only(bottom: 10),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.purple,
                    child: Text(
                      'JD',
                      style: TextStyle(fontSize: 44, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Jane Doe',
                    style: TextStyle(fontSize: 20),
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
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: const Color.fromRGBO(29, 27, 32, 1),
              ),
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: dodadi funkcii za prenosacuvanje kon drugi stranici
                  const ProfileMenuItem(title: "Your Menus"),
                  ProfileMenuItem(
                    title: "Favorite Menus",
                    onTap: () {},
                  ),
                  const ProfileMenuItem(title: "Profile Settings"),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionItem extends StatelessWidget {
  final String title;

  const SectionItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
