class MenuItemModel {
  late String menuItemId;
  late String name;
  late num price;
  late String description;

  MenuItemModel({
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'menuItemId': menuItemId,
      'name': name,
      'price': price,
      'description': description,
    };
  }

  factory MenuItemModel.fromMap(Map<String, dynamic> data) {
    return MenuItemModel(
      menuItemId: data['menuItemId'],
      name: data['name'],
      price: data['price'],
      description: data['description'],
    );
  }
}
