import 'package:flutter/material.dart';
import 'package:menu_craft/models/body_pages.dart';
import 'package:menu_craft/models/navigation_icons.dart';
import 'package:menu_craft/widgets/bottom_navigation/navigation_destination.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.orangeAccent,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Image.asset('images/logo.jpg'),
        //   onPressed: () {},
        // ),
        backgroundColor: const Color.fromRGBO(16, 20, 24, 1),
        title: const Center(
          child: Text(
            'MenuCraft',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                color: Colors.white),
          ),
        ),
      ),
      body: BodyPages.pages[currentPage],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromRGBO(16, 20, 24, 1),
        destinations: NavigationIcons.icons
            .map((icon) => navigationDestination(icon))
            .toList(),
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
