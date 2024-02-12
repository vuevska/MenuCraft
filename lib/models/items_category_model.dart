import 'package:flutter/material.dart';

class ItemsCategoryModel {
  late String categoryId;
  late String name;
  late IconData icon;

  ItemsCategoryModel({
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

  factory ItemsCategoryModel.fromMap(Map<String, dynamic> data) {
    return ItemsCategoryModel(
      categoryId: data['categoryId'],
      name: data['name'],
      icon: IconData(data['icon'], fontFamily: 'MaterialIcons'),
    );
  }
}
