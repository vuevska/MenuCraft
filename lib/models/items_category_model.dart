import 'package:flutter/material.dart';

class ItemsCategoryModel {
  late String categoryId;
  late String name;
  late int icon;

  ItemsCategoryModel({
    required this.categoryId,
    required this.name,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'iconCodePoint': icon,
    };
  }

  factory ItemsCategoryModel.fromMap(Map<String, dynamic> data) {
    return ItemsCategoryModel(
      categoryId: data['categoryId'],
      name: data['name'],
      icon: data['iconCodePoint'],
    );
  }

  IconData getIconData() {
    return IconData(icon, fontFamily: 'MaterialIcons');
  }
}
