import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final List<String> category;
  final String name;
  final String categoryID;
  final String image_url;
  final double weight;
  final int price;
  final double rating;
  final List<String> rawMaterials;
  final List<String> manufacturer;
  final double totalEmission;
  final int totalManufacturers;
  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.categoryID,
    required this.image_url,
    required this.weight,
    required this.price,
    required this.rating,
    required this.rawMaterials,
    required this.manufacturer,
    required this.totalEmission,
    required this.totalManufacturers,
  });

  Product copyWith({
    String? id,
    List<String>? category,
    String? name,
    String? categoryID,
    String? image_url,
    double? weight,
    int? price,
    double? rating,
    List<String>? rawMaterials,
    List<String>? manufacturer,
    double? totalEmission,
    int? totalManufacturers,
  }) {
    return Product(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      categoryID: categoryID ?? this.categoryID,
      image_url: image_url ?? this.image_url,
      weight: weight ?? this.weight,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      rawMaterials: rawMaterials ?? this.rawMaterials,
      manufacturer: manufacturer ?? this.manufacturer,
      totalEmission: totalEmission ?? this.totalEmission,
      totalManufacturers: totalManufacturers ?? this.totalManufacturers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'category': category,
      'name': name,
      'categoryID': categoryID,
      'image_url': image_url,
      'weight': weight,
      'price': price,
      'rating': rating,
      'rawMaterials': rawMaterials,
      'manufacturer': manufacturer,
      'totalEmission': totalEmission,
      'totalManufacturers': totalManufacturers,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      category: List<String>.from(map['category']),
      name: map['name'] ?? '',
      categoryID: map['categoryID'] ?? '',
      image_url: map['image_url'] ?? '',
      weight: map['weight']?.toDouble() ?? 0.0,
      price: map['price']?.toInt() ?? 0,
      rating: map['rating']?.toDouble() ?? 0.0,
      rawMaterials: List<String>.from(map['rawMaterials']),
      manufacturer: List<String>.from(map['manufacturer']),
      totalEmission: map['totalEmission']?.toDouble() ?? 0.0,
      totalManufacturers: map['totalManufacturers']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(_id: $id, category: $category, name: $name, categoryID: $categoryID, image_url: $image_url, weight: $weight, price: $price, rating: $rating, rawMaterials: $rawMaterials, manufacturer: $manufacturer, totalEmission: $totalEmission, totalManufacturers: $totalManufacturers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        listEquals(other.category, category) &&
        other.name == name &&
        other.categoryID == categoryID &&
        other.image_url == image_url &&
        other.weight == weight &&
        other.price == price &&
        other.rating == rating &&
        listEquals(other.rawMaterials, rawMaterials) &&
        listEquals(other.manufacturer, manufacturer) &&
        other.totalEmission == totalEmission &&
        other.totalManufacturers == totalManufacturers;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        name.hashCode ^
        categoryID.hashCode ^
        image_url.hashCode ^
        weight.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        rawMaterials.hashCode ^
        manufacturer.hashCode ^
        totalEmission.hashCode ^
        totalManufacturers.hashCode;
  }
}
