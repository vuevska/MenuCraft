import 'package:flutter/material.dart';

class CategoryModel {
  late String categoryId;
  late String name;
  late IconData icon;

  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'icon': icon.codePoint,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
      categoryId: data['categoryId'],
      name: data['name'],
      icon: IconData(data['icon'], fontFamily: 'MaterialIcons'),
    );
  }
}
