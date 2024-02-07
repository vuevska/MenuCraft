import 'package:flutter/material.dart';
import 'package:menu_craft/pages/scan_qr_page.dart';

class CardButton extends StatelessWidget {
  const CardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).cardColor,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QrScanner()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Scan QR Code",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ),
                  Image(image: AssetImage('images/qr.png')),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60.0,
          ),

          // ListView.builder(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   itemCount: allRestaurants.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return FavoriteRestaurantCard(
          //       restaurant: allRestaurants[index],
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
