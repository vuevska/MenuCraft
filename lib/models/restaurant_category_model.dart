class RestaurantCategoryModel {
  late String categoryId;
  late String name;
  late String iconImage;

  RestaurantCategoryModel({
    required this.categoryId,
    required this.name,
    required this.iconImage,
  });

  factory RestaurantCategoryModel.fromMap(Map<String, dynamic> data) {
    return RestaurantCategoryModel(
      categoryId: data['categoryId'],
      name: data['name'],
      iconImage: data['iconImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'iconImage': iconImage,
    };
  }
}
