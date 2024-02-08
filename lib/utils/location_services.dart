import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends ChangeNotifier {
  Position? _currentPosition;
  String _currentAddress = '';

  static LocationPermission locationPermission = LocationPermission.denied;

  Position? get currentPosition => _currentPosition;

  String get currentAddress => _currentAddress;

  static Future<String> getAddress(double latitude, double longitude) async {
    var placemarks = await placemarkFromCoordinates(latitude, longitude);
    return "${placemarks[0].street} ${placemarks[0].administrativeArea} ${placemarks[0].isoCountryCode}";
  }

  static bool checkPermission() {
    return locationPermission == LocationPermission.always || locationPermission == LocationPermission.whileInUse;
  }

  static Future<Position?> getLastKnownPosition() async {
    return  Geolocator.getLastKnownPosition();

  }

  void determinePosition() async {
    if (_currentPosition != null) {
      return;
    }
    bool serviceEnabled;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _currentPosition = await Geolocator.getCurrentPosition();

    var placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude);

    _currentAddress =
        "${placemarks[0].street} ${placemarks[0].administrativeArea} ${placemarks[0].isoCountryCode}";
    notifyListeners();
  }

}
