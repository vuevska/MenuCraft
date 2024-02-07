class Restaurant {
  final String name;
  final String location;
  final String imageUrl;

  Restaurant({
    required this.name,
    required this.location,
    required this.imageUrl,
  });

  factory Restaurant.fromMap(Map<String, dynamic> data) {
    return Restaurant(
      name: data['name'],
      location: data['location'],
      imageUrl: data['imagePath'] ?? "",
    );
  }
}
