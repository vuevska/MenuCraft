import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:provider/provider.dart';

import '../../utils/data_upward.dart';
import '../../utils/location_services.dart';

class LocationPickPage extends StatefulWidget {
  const LocationPickPage({super.key, required this.locationController, required this.refresh});

  final Data<PickedData>? locationController;
  final Function refresh;
  @override
  State<LocationPickPage> createState() => _LocationPickPageState();
}

class _LocationPickPageState extends State<LocationPickPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a location'),
      ),
      body: FlutterLocationPicker(
        initPosition: LatLong(
            context.read<LocationService>().currentPosition?.latitude ??
                41.996111,
            context.read<LocationService>().currentPosition?.longitude ??
                21.431667),
        onPicked: (pickedData) {
          widget.locationController?.data = pickedData;
          widget.refresh();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
