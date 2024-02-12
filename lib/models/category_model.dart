import 'package:flutter/cupertino.dart';

class CategoryModel {
  late String categoryId;
  late String name;
  late String iconImage;

  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.iconImage,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
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
