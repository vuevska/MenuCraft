import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class RestaurantModel {
  late String restaurantId;
  late String name;
  late String geoHash;
  late double latitude;
  late double longitude;
  late String imageUrl;
  late String owningUserID;
  late String category;

  final _geo = GeoFlutterFire();

  RestaurantModel(
      {required this.restaurantId,
      required this.name,
      required this.geoHash,
      required this.latitude,
      required this.longitude,
      required this.imageUrl,
      required this.owningUserID,
      required this.category});

  factory RestaurantModel.fromMap(
    Map<String, dynamic> data,
  ) {
    Map<String, dynamic> geoPoint = data['geoPoint'] as Map<String, dynamic>;
    String geoHash = geoPoint['geohash'];
    double latitude = (geoPoint['geopoint'] as GeoPoint).latitude;
    double longitude = (geoPoint['geopoint'] as GeoPoint).longitude;

    return RestaurantModel(
      restaurantId: data['restaurantId'],
      name: data['name'],
      geoHash: geoHash,
      latitude: latitude,
      longitude: longitude,
      imageUrl: data['imageUrl'] ?? "",
      owningUserID: data['owningUserID'] ?? "",
      category: data['category'] ?? "",
    ); //TODO: akop nema nekoe pole da ne eksplodira cela aplikacija
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
      'name': name,
      'geoPoint': _geo.point(latitude: latitude, longitude: longitude).data,
      'imageUrl': imageUrl,
      'owningUserID': owningUserID,
      'category': category,
    };
  }
}
