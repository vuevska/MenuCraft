class RestaurantModel {
  late String restaurantId;
  late String name;
  late String location;
  late String imageUrl;

  RestaurantModel({
    required this.restaurantId,
    required this.name,
    required this.location,
    required this.imageUrl,
  });

  factory RestaurantModel.fromMap(Map<String, dynamic> data) {
    return RestaurantModel(
      restaurantId: data['restaurantId'],
      name: data['name'],
      location: data['location'],
      imageUrl: data['imageUrl'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
    };
  }
}
