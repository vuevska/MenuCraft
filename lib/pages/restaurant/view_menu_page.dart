import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/secondary_custom_appbar.dart';

class ViewMenuPage extends StatefulWidget {
  const ViewMenuPage({super.key});

  @override
  State<ViewMenuPage> createState() => _ViewMenuPageState();
}

class _ViewMenuPageState extends State<ViewMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: const Column(
          children: [
            SecondaryCustomAppBar(title: "View Menu Details"),
            SizedBox(height: 20.0),
            Text(
              "Pregled na meni tuka",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
