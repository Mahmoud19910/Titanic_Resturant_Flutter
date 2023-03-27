import 'package:flutter/foundation.dart';

class Category{
final String id;
final String imageUrl;
final String description;
final String nameCategory;

Category({required this.id, required this.imageUrl, required this.description, required this.nameCategory});

factory Category.fromJson(Map<String, dynamic> json) {
  return Category(
    id: json['idCategory'],
    nameCategory: json['strCategory'],
    imageUrl: json['strCategoryThumb'],
    description: json['strCategoryDescription'],
  );
}
}