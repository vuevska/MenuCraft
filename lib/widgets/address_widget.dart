import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/location_services.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: LocationService.getAddress(
        widget.latitude,
        widget.longitude,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Finding location...");
        }
        if (snapshot.hasError) {
          return const Text('Error finding location');
        }
        if (snapshot.hasData) {
          return GestureDetector(
            onLongPress: () {
              launchUrl(
                Uri.parse(
                  'https://www.google.com/maps/search/?api=1&query=${widget.latitude},${widget.longitude}',
                ),
                mode: LaunchMode.externalApplication,
              );
            },
            child: Column(
              children: [
                const SizedBox(height: 4.0),
                Text(
                  snapshot.data!,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
