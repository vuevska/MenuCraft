import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  late String restaurantId;
  late String name;
  late double latitude;
  late double longitude;
  late String imageUrl;
  late String owningUserID;

  RestaurantModel({
    required this.restaurantId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.owningUserID,
  });

  factory RestaurantModel.fromMap(Map<String, dynamic> data) {

    return RestaurantModel(
      restaurantId: data['restaurantId'],
      name: data['name'],
      latitude: data['geoPoint'].latitude ?? 34.000,
      longitude: data['geoPoint'].longitude ??  32.000,
      imageUrl: data['imageUrl'] ?? "",
      owningUserID: data['owningUserID'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
      'name': name,
      'geoPoint': GeoPoint(latitude, longitude),
      'imageUrl': imageUrl,
      'owningUserID': owningUserID,
    };
  }
}
